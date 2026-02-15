@abstract class_name Enemy
extends CharacterBody2D

## How often (in seconds) this enemy attacks the explorer.
@export var attackSpeed: float = 1.0
## The enemy's health.
@export var health := 1
## A scene that gets spawned by `spawnAttack`.
@export var ATTACK: PackedScene = preload("res://game/bullet.tscn")

## Emitted when the explorer collides with this enemy.
signal collideExplorer
## Emitted when the enemy should attack.
signal attack

## Called when the enemy should attack the explorer.
func _attack(player: CharacterBody2D):
	pass

## Called when the enemy collides with the explorer.
##
## The default implementation just makes the enemy lose a health if the player was offensively
## dashing.
func _collideExplorer(explorer: Explorer):
	if explorer.player_state == Explorer.PlayerState.OffensiveDash:
		self.health -= 1
	
		if self.health == 0:
			self.free()

func _init():
	self.collideExplorer.connect(self._collideExplorer)
	self.attack.connect(self._attack)
	self.ready.connect(func():
		var timer = Timer.new()
		timer.name = "EnemyFireTimer"
		timer.autostart = true
		timer.wait_time = self.attackSpeed
		timer.connect('timeout', func(): self.attack.emit($/root/Game/Explorer))
		self.add_child(timer)
	)

func spawnAttack() -> Node2D:
	var attack = self.ATTACK.instantiate()
	attack.position = self.position
	$/root/Game/Bullets.add_child(attack)
	return attack
