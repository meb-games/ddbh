@abstract class_name Enemy
extends CharacterBody2D

## How often (in seconds) this enemy fires bullets.
@export var fireSpeed: float = 1.0

static var BULLET: PackedScene = preload("res://game/bullet.tscn")

func _init():
	self.connect('ready', self.__enemy_ready)

func __enemy_ready():
	var explorer = $/root/Game/Explorer
	var timer = Timer.new()
	timer.name = "EnemyFireTimer"
	timer.autostart = true
	timer.wait_time = self.fireSpeed
	timer.connect('timeout', func(): self._fire(explorer))
	self.add_child(timer)

@abstract func _fire(player: CharacterBody2D)
