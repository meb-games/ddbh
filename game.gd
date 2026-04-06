extends Node2D

func load_level(name: String) -> void:
	$/root/Game.add_child(load("res://game/levels/%s.tscn" % name).instantiate())

func _ready() -> void:
	self.load_level("1")
