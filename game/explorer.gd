extends CharacterBody2D

const MAX_HEALTH = 10.0
@export var speed := 400.0
@export var health := MAX_HEALTH

@export var max_dash_distance := 220.0
@export var dash_speed := 1500.0

# When enabled, the player will always dash the same distance; when disabled,
# the player dashes to the mouse's location
@export var constant_dash_distance := false

# Stores what the player is currently doing. The number is a damage multiplier for the player's
# state.
var player_state := PlayerState.Normal
enum PlayerState {
	DefensiveDash = 0,
	Normal = 1,
	OffensiveDash = 2
}
# The direction the player is dashing
var dash_dir := Vector2.ZERO
# How much farther the player needs to dash
var dash_distance := 0.0

func _physics_process(delta: float) -> void:
	if player_state == PlayerState.Normal:
		velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed * delta
	else:
		velocity = (dash_dir * dash_speed * delta).limit_length(dash_distance)
		var new_pos := self.position + velocity
		dash_distance -= self.position.distance_to(new_pos)
		
		if dash_distance <= 0.50:
			player_state = PlayerState.Normal
			velocity = Vector2.ZERO
	
	self.position += velocity

	if Input.is_action_just_pressed("dash_defensive"):
		start_dash(PlayerState.DefensiveDash)
	elif Input.is_action_just_pressed("dash_offensive"):
		start_dash(PlayerState.OffensiveDash)

# Makes the player dash in the direction of the mouse.
func start_dash(kind: PlayerState) -> void:
	var mouse_pos := get_global_mouse_position()
	player_state = kind
	if constant_dash_distance:
		dash_distance = max_dash_distance
	else:
		dash_distance = min(self.position.distance_to(mouse_pos), max_dash_distance)
	dash_dir = self.position.direction_to(mouse_pos)
	if dash_dir == Vector2.ZERO:
		dash_dir = Vector2.RIGHT # fallback if mouse exactly on player

func take_hit(base_damage: int) -> void:
	var damage := base_damage * player_state
	health -= damage
	update_health_ui()

func _process(_delta: float):
	if health <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

# Health Bar Code
func update_health_ui():
	$"../HealthBar".value = health
