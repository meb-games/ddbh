extends Enemy

const HOP_DISTANCE := 60.0
const SPEED := 100.0
const TOLERANCE := Vector2(0.5, 0.5)

var to_move := Vector2(0.0, 0.0)
var direction := Vector2(0.0, 0.0)

func _physics_process(delta: float) -> void:
	var velocity = self.direction * SPEED * delta
	var magnitude = self.to_move.abs()
	
	if magnitude < velocity.abs():
		velocity = self.to_move
	
	self.to_move -= velocity
	self.position += velocity
	
	if magnitude.x <= 0.5 && magnitude.y <= 0.5:
		self.direction = Vector2.ZERO

func _act(explorer: CharacterBody2D):
	# For x and y we move the slime -1, 0, or 1 units in the x and y direction
	# A 'unit' in this case is just HOP_DISTANCE
	var movx = float(randi_range(-1, 1))
	var movy = float(randi_range(-1, 1))
	
	self.direction = Vector2(movx, movy)
	self.to_move = self.direction * HOP_DISTANCE
	print(self.direction, self.to_move)
