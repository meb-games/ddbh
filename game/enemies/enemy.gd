@abstract class_name Enemy
extends CharacterBody2D



# 
# Editor Features & APIs
# 


## How often (in ticks) the enemy acts.
@export var ACTION_SPEED: int = 120
## A scene that gets spawned by `spawn_attack`.
@export var ATTACK: PackedScene = preload("res://game/attacks/bullet.tscn")

## The enemy's health.
@export var health: int = 1

# Movement System

## A range for how close an enemy needs to be to a specific position before
## it's considered there.
@export var MOVEMENT_TOLERANCE := Vector2(.5, .5)
## How fast the enemy can move.
@export var movement_speed: float = 50.0
## How far the enemy currently needs to move.
##
## Set to a `Vector2` to constrain how far the enemy can move. Set to `null` to
## let the enemy move forever.
var movement_distance = null
## The direction the enemy is moving in.
var movement_direction := Vector2(0, 0)
## The last tick number when the player collided with this enemy, sorted by player states..
var last_player_collision_tick: Dictionary[Explorer.PlayerState, int] = {}

func spawn_attack() -> Node2D:
    var attack = self.ATTACK.instantiate()
    attack.position = self.position
    $/root/Game/Attacks.add_child(attack)
    return attack

func move_by(direction: Vector2, distance: float):
    self.movement_direction = direction
    self.movement_distance = direction * distance



# 
# Signals & Callbacks
# 


signal hit_by_bullet
func _hit_by_bullet(bullet: Bullet):
    if bullet.kind == Bullet.BulletKind.Defensive || bullet.team == Bullet.BulletTeam.Enemy:
        return
    
    self.health -= 1
    bullet.queue_free()

var _ticks_to_act: int = self.ACTION_SPEED
func _tick():
    self._ticks_to_act -= 1
    if self._ticks_to_act == 0:
        self._act($/root/Game/Explorer)
        self._ticks_to_act = self.ACTION_SPEED

## Called when the enemy should take an action.
func _act(_explorer: CharacterBody2D):
    pass

## Called every frame the enemy is colliding with the explorer.
func _colliding_with_explorer(explorer: Explorer):
    var current_tick: int = $/root/Game.tick
    var last_collision_in_state = self.last_player_collision_tick.get(explorer.state, 0)
    if current_tick - last_collision_in_state > 1:
        self._hit_by_explorer(explorer)
    self.last_player_collision_tick.set(explorer.state, current_tick)

## Called when the enemy collides with the explorer.
func _hit_by_explorer(explorer: Explorer):
    pass

## Called if the enemy needs to stop (e.g. because the player has left the enemy's room).
func _stop():
    pass



# 
# Internals
# 



func _notification(what: int) -> void:
    if !self.is_inside_tree():
        return
        
    match what:
        NOTIFICATION_PREDELETE:
            self.get_parent().get_parent()._on_enemy_die()

        NOTIFICATION_READY:
            self.hit_by_bullet.connect(self._hit_by_bullet)
            self.set_physics_process(true)
            
            # Sleep a random time between 0 and 1 seconds
            # This makes enemies that spawn at the same time still attack at
            # slightly different times
            await get_tree().create_timer(randf_range(0.0, 1.0)).timeout

        NOTIFICATION_PHYSICS_PROCESS:
            if self.health <= 0:
                self.queue_free()
                return
            
            var delta = Engine.time_scale / Engine.physics_ticks_per_second
            self.velocity = self.movement_speed * self.movement_direction * delta
            
            if self.movement_distance != null: 
                # Prevent overshooting the enemy's max position
                var adistance = self.movement_distance.abs()
                var amovement = self.velocity.abs()
                # vector < other != (vector.x < other.x && vector.y < other.y)
                # idk why
                if adistance.x < amovement.x && adistance.y < amovement.y:
                    self.velocity = self.movement_distance
                
                self.movement_distance -= self.velocity
                
                if adistance.x <= self.MOVEMENT_TOLERANCE.x && adistance.y <= self.MOVEMENT_TOLERANCE.y:
                    self.movement_direction = Vector2.ZERO
            
            self.move_and_collide(self.velocity)
