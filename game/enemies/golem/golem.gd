@abstract class_name Golem
extends Enemy

const SLAM_RANGE: float = 50.0
const CHARGED_SLAM_RANGE: float = 200.0
@abstract func check_state(distance: float)

enum GolemState {
	FOLLOW,
	START_SLAM,
	DO_SLAM,
	START_CHARGED_SLAM,
	DO_CHARGED_SLAM,
	COOLDOWN
}
var state := GolemState.FOLLOW
var can_charged_slam := true

enum GolemAttack {
	NORMAL,
	CHARGED
}

func _init():
	self.ACTION_SPEED = 1

func _act(explorer: CharacterBody2D):
	match self.state:
		GolemState.FOLLOW:
			self.movement_direction = self.global_position.direction_to(explorer.global_position)
			self.check_state(self.global_position.distance_to(explorer.global_position))
		
		GolemState.START_SLAM:
			print("telegraphing slam")
			self.change_state(.5, GolemState.DO_SLAM)
		GolemState.DO_SLAM:
			$/root/Game/Explorer._hit_by_attack(self, GolemAttack.NORMAL)
			self.change_state(1.0, GolemState.FOLLOW)
			
		GolemState.START_CHARGED_SLAM:
			self.change_state(.5, GolemState.DO_CHARGED_SLAM)
		GolemState.DO_CHARGED_SLAM:
			self.can_charged_slam = false
			print("todo charged slam")
			self.change_state(1.0, GolemState.FOLLOW)
			get_tree().create_timer(10.0).timeout.connect(func():
				self.can_charged_slam = true
			)

func change_state(delay: float, new_state: GolemState):
	self.movement_direction = Vector2.ZERO
	self.state = GolemState.COOLDOWN
	await get_tree().create_timer(delay).timeout
	self.state = new_state

func _stop():
	self.movement_direction = Vector2.ZERO
