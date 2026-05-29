class_name Explorer
extends CharacterBody2D

@export var speed := 400.0

const DEFENSIVE_BULLET := preload("res://game/attacks/defensive-bullet.tscn")
const OFFENSIVE_BULLET := preload("res://game/attacks/offensive-bullet.tscn")

enum PlayerState {
    Normal = 0,
    Hit = 1
}
var state: PlayerState

enum BulletKind {
    Defensive = 0,
    Offensive = 1
}

## Number of invincibility frames the player has remaining.
var invi_frames = 5
## The direction the explorer is dashing
var dash_dir := Vector2.ZERO
## How much farther the explorer needs to dash
var dash_distance := 0.0
const DEFAULT_COLLISION_MASK := 0

func _init() -> void:
    self.hit_by_bullet.connect(self._hit_by_bullet)

func _physics_process(delta: float) -> void:
    self.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed * delta
    self.move_and_collide(self.velocity)

    if Input.is_action_just_pressed("dash_defensive"):
        shoot(DEFENSIVE_BULLET)
    elif Input.is_action_just_pressed("dash_offensive"):
        shoot(OFFENSIVE_BULLET)

func shoot(bullet_scene: PackedScene) -> void:
    var mouse_pos := get_global_mouse_position()
    var bullet: Bullet = bullet_scene.instantiate()
    
    bullet.direction = self.position.direction_to(mouse_pos)
    bullet.position = self.global_position + (bullet.direction * 80)
    if bullet.direction == Vector2.ZERO:
        bullet.direction = Vector2.RIGHT # fallback if mouse exactly on explorer
    $/root/Game/Attacks.add_child(bullet)

func update_collision():
    self.collision_mask = DEFAULT_COLLISION_MASK | (1 << self.state)
    $Area2D.collision_mask = self.collision_mask



# 
# Signals
# 



signal hit_by_bullet
func _hit_by_bullet(bullet: Bullet) -> void:
    if bullet.kind == Bullet.BulletKind.Defensive || bullet.team == Bullet.BulletTeam.Explorer:
        return
    
    match self.state:
        PlayerState.Normal:
            var dmg = 1 * self.state
            self.state = PlayerState.Hit
            
            $Health.change.emit(dmg)
        PlayerState.Hit:
            pass

# non-bullet enemy attacks
func _hit_by_attack(enemy: Enemy, data):
    self.state = PlayerState.Hit
    if enemy is Golem:
        match data as Golem.GolemAttack:
            Golem.GolemAttack.NORMAL:
                $Health.change.emit(-2)
            Golem.GolemAttack.CHARGED:
                $Health.change.emit(-1)

func _process(_delta: float) -> void:
    if $Health.value() <= 0:
        get_tree().change_scene_to_file.call_deferred("res://game_over.tscn")
    
    match self.state:
        PlayerState.Normal:
            self.modulate = Color.WHITE
        PlayerState.Hit:
            self.modulate = Color.RED
            self.invi_frames -= 1
            if self.invi_frames == 0:
                self.state = PlayerState.Normal
                self.invi_frames = 5
    
    for node in $Area2D.get_overlapping_bodies():
        if node is Enemy:
            node._colliding_with_explorer(self)
