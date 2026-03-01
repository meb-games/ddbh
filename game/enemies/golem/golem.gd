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

func _init():
	self.ACTION_SPEED = 1.0 / Engine.physics_ticks_per_second

func _act(explorer: CharacterBody2D):
	match self.state:
		GolemState.FOLLOW:
			self.movement_direction = self.position.direction_to(explorer.position)
			self.check_state(self.position.distance_to(explorer.position))
		
		GolemState.START_SLAM:
			self.change_state(.5, GolemState.DO_SLAM)
		GolemState.DO_SLAM:
			print("todo slam")
			self.change_state(1.0, GolemState.FOLLOW)
			
		GolemState.START_CHARGED_SLAM:
			self.change_state(.5, GolemState.DO_CHARGED_SLAM)
		GolemState.DO_CHARGED_SLAM:
			print("todo charged slam")
			self.change_state(1.0, GolemState.FOLLOW)

func change_state(delay: float, new_state: GolemState):
	self.movement_direction = Vector2.ZERO
	self.state = GolemState.COOLDOWN
	await get_tree().create_timer(delay).timeout
	self.state = new_state
