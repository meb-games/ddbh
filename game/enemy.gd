@abstract class_name Enemy
extends CharacterBody2D



# 
# Editor Features & APIs
# 


## How often (in seconds) this enemy attacks the explorer.
@export var attack_speed: float = 2.0
## The enemy's health.
@export var health := 1
## A scene that gets spawned by `spawnAttack`.
@export var ATTACK: PackedScene = preload("res://game/bullet.tscn")

func spawnAttack() -> Node2D:
	var attack = self.ATTACK.instantiate()
	attack.position = self.position
	$/root/Game/Bullets.add_child(attack)
	return attack



# 
# Callbacks
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
	print("Hit by explorer")
	if explorer.state == Explorer.PlayerState.OffensiveDash:
		self.health -= 1
	
		if self.health == 0:
			self.queue_free()



# 
# Internals
# 



func _init():
	self.hit_by_explorer.connect(self._hit_by_explorer)
	self.act.connect(self._act)
	self.ready.connect(func():
		await get_tree().create_timer(randf_range(0.0, 1.0)).timeout
		var timer = Timer.new()
		timer.name = "EnemyFireTimer"
		timer.autostart = true
		timer.wait_time = self.attack_speed
		timer.connect('timeout', func(): self.act.emit($/root/Game/Explorer))
		self.add_child(timer)
	)
