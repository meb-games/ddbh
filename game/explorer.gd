extends CharacterBody2D

@export var speed := 400.0
@export var health = 10

@export var dash_distance := 220.0
@export var dash_speed := 1500.0

var damage_mult := 1 # 0 = i-frames, 1 = normal, 2 = double damage

var dashing := false
var dash_dir := Vector2.ZERO
var dash_remaining := 0.0

func _physics_process(delta: float) -> void:
    if dashing:
        velocity = dash_dir * dash_speed
        move_and_slide()

        dash_remaining -= dash_speed * delta
        if dash_remaining <= 0.0:
            dashing = false
            damage_mult = 1
            velocity = Vector2.ZERO
        return

    # normal movement
    velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
    move_and_slide()

    # start dash (toward mouse)
    if Input.is_action_just_pressed("dash_defensive"):
        start_dash(0.0)
    elif Input.is_action_just_pressed("dash_offensive"):
        start_dash(2.0)

func start_dash(mult: float) -> void:
    dashing = true
    damage_mult = mult
    dash_remaining = dash_distance
    dash_dir = (get_global_mouse_position() - global_position).normalized()
    if dash_dir == Vector2.ZERO:
        dash_dir = Vector2.RIGHT # fallback if mouse exactly on player

func take_hit(base_damage: int) -> void:
    var damage := int(base_damage * damage_mult)

    if damage <= 0:
        return # i-frames

    health -= damage
    # Optional: clamp so it never goes below zero
    health = max(health, 0)

    if health <= 0:
        die()

func die() -> void:
    get_tree().change_scene_to_file("res://game_over.tscn")
