@abstract class_name Enemy
extends CharacterBody2D

## How often (in seconds) this enemy fires bullets.
@export var fireSpeed: float = 1.0
## The enemy's health. Each time the player hits the enemy with an offensive
## dash, the enemy loses 1 health.
@export var health := 1
## The type of bullet the enemy will fire.
@export var BULLET: PackedScene = preload("res://game/bullet.tscn")

## The enemy collided with the player.
signal collide_player
## The enemy needs to fire a bullet.
signal fire

func _init():
	self.connect('ready', self.__enemy_ready)
	self.collide_player.connect(self._on_collide_player)
	self.fire.connect(self._on_fire)

func __enemy_ready():
	var timer = Timer.new()
	timer.name = "EnemyFireTimer"
	timer.autostart = true
	timer.wait_time = self.fireSpeed
	timer.connect('timeout', func(): self.fire.emit($/root/Game/Explorer))
	self.add_child(timer)

func spawnBullet() -> Node2D:
	var bullet = self.BULLET.instantiate()
	bullet.position = self.position
	$/root/Game/Bullets.add_child(bullet)
	return bullet

## Called when the enemy needs to fire bullets.
@abstract func _on_fire(player: CharacterBody2D)

func _on_collide_player():
	self.health -= 1
	
	if self.health == 0:
		queue_free()
