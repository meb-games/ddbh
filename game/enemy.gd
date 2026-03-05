@abstract class_name Enemy
extends CharacterBody2D



# 
# Editor Features & APIs
# 


## How often (in seconds) this enemy performs actions.
@export var ACTION_SPEED: float = 2.0
## A scene that gets spawned by `spawn_attack`.
@export var ATTACK: PackedScene = preload("res://game/bullet.tscn")

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



## Emitted when the explorer collides with this enemy.
signal hit_by_explorer
## Emitted when the enemy should take an action.
signal act

## Called when the enemy should take an action.
func _act(explorer: CharacterBody2D):
    pass

## Called when the enemy collides with the explorer.
##
## The default implementation just makes the enemy lose a health if the player was offensively
## dashing.
func _hit_by_explorer(explorer: Explorer):
    if explorer.state == Explorer.PlayerState.OffensiveDash:
        self.health -= 1
    
        if self.health == 0:
            self.queue_free()



# 
# Internals
# 



func _notification(what: int) -> void:
    match what:
        NOTIFICATION_READY:
            # Connect signals -> default callbacks
            self.hit_by_explorer.connect(self._hit_by_explorer)
            self.act.connect(self._act)
            self.set_physics_process(true)
            
            # Sleep a random time between 0 and 1 seconds
            # This makes enemies that spawn at the same time still attack at
            # slightly different times
            await get_tree().create_timer(randf_range(0.0, 1.0)).timeout
            
            # Loop enemy actions
            var timer = Timer.new()
            timer.name = "EnemyActionTimer"
            timer.autostart = true
            timer.wait_time = self.ACTION_SPEED
            timer.connect('timeout', func(): self.act.emit($/root/Game/Explorer))
            self.add_child(timer)
        
        NOTIFICATION_PHYSICS_PROCESS:
            var delta = Engine.time_scale / Engine.physics_ticks_per_second
            var movement = self.movement_speed * self.movement_direction * delta
            
            if self.movement_distance != null: 
                # Prevent overshooting the enemy's max position
                var adistance = self.movement_distance.abs()
                var amovement = movement.abs()
                # vector < other != (vector.x < other.x && vector.y < other.y)
                # idk why
                if adistance.x < amovement.x && adistance.y < amovement.y:
                    movement = self.movement_distance
                
                self.movement_distance -= movement
                
                if adistance.x <= self.MOVEMENT_TOLERANCE.x && adistance.y <= self.MOVEMENT_TOLERANCE.y:
                    self.movement_direction = Vector2.ZERO
            
            self.position += movement
