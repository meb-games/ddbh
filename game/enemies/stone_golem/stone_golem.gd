extends Enemy

const GROUND_SLAME_RANGE: float = 50.0
const COOLDOWN_DURATION: float = 1

enum GolemState {
	FOLLOW,
	SLAM,
	COOLDOWN
}
var state := GolemState.FOLLOW

func _init():
	self.ACTION_SPEED = 1.0 / Engine.physics_ticks_per_second

func _act(explorer: CharacterBody2D):
	match self.state:
		GolemState.FOLLOW:
			var distance_to_explorer = self.position.distance_to(explorer.position)
			if distance_to_explorer <= GROUND_SLAME_RANGE:
				self.state = GolemState.SLAM
			else:
				self.movement_direction = self.position.direction_to(explorer.position)
		
		GolemState.SLAM:
			print("get slamd lol")
			self.movement_direction = Vector2.ZERO
			self.state = GolemState.COOLDOWN
			await get_tree().create_timer(COOLDOWN_DURATION).timeout
			self.state = GolemState.FOLLOW
