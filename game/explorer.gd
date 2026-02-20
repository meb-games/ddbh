class_name Explorer
extends CharacterBody2D

const MAX_HEALTH = 10.0
@export var speed := 400.0
@export var health := MAX_HEALTH

@export var max_dash_distance := 220.0
@export var dash_speed := 1500.0

# When enabled, the explorer will always dash the same distance; when disabled,
# the explorer dashes to the mouse's location
@export var constant_dash_distance := false

## Stores what the explorer is currently doing. The number is a damage multiplier for the explorer's
## state.
var state := PlayerState.Normal
enum PlayerState {
	DefensiveDash = 0,
	Normal = 1,
	OffensiveDash = 2
}
## The direction the explorer is dashing
var dash_dir := Vector2.ZERO
## How much farther the explorer needs to dash
var dash_distance := 0.0

signal health_changed(float)

func _init() -> void:
	self.health_changed.connect(func(health: float):
		if health <= 0:
			get_tree().change_scene_to_file.call_deferred("res://game_over.tscn")
		
		self.health = health
	)
	self.hit_by_bullet.connect(self._hit_by_bullet)

func _physics_process(delta: float) -> void:
	if self.state == PlayerState.Normal:
		self.position += Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed * delta
	else:
		velocity = (dash_dir * dash_speed * delta).limit_length(dash_distance)
		var new_pos := self.position + velocity
		self.dash_distance -= self.position.distance_to(new_pos)
		self.position = new_pos
		
		if dash_distance <= 0.50:
			self.modulate = Color.WHITE
			self.state = PlayerState.Normal
			velocity = Vector2.ZERO

	if Input.is_action_just_pressed("dash_defensive"):
		self.modulate = Color(0, 0, 255)
		start_dash(PlayerState.DefensiveDash)
	elif Input.is_action_just_pressed("dash_offensive"):
		self.modulate = Color(255, 0, 0)
		start_dash(PlayerState.OffensiveDash)

# Makes the explorer dash in the direction of the mouse.
func start_dash(kind: PlayerState) -> void:
	var mouse_pos := get_global_mouse_position()
	self.state = kind
	if constant_dash_distance:
		dash_distance = max_dash_distance
	else:
		dash_distance = min(self.position.distance_to(mouse_pos), max_dash_distance)
	dash_dir = self.position.direction_to(mouse_pos)
	if dash_dir == Vector2.ZERO:
		dash_dir = Vector2.RIGHT # fallback if mouse exactly on explorer

func _on_body_entered(body: Node) -> void:
	if self.state == PlayerState.OffensiveDash && body.has_signal("hit_by_explorer"):
		body.emit_signal("hit_by_explorer", self)



# 
# Signals
# 



signal hit_by_bullet
func _hit_by_bullet(_bullet: Bullet) -> void:
	var damage := 1 * self.state
	self.health_changed.emit(self.health - damage)
