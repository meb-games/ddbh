extends Node2D

var tick := 0
@export var level_to_load: int = 1

func load_level(level: int) -> void:
	$/root/Game.add_child(load("res://game/levels/%s.tscn" % level).instantiate())

func _ready() -> void:
	self.load_level(level_to_load)

func _process(_delta: float) -> void:
	self.tick += 1
