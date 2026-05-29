extends Node2D

var tick := 0

func load_level(level_name: String) -> void:
	$/root/Game.add_child(load("res://game/levels/%s.tscn" % level_name).instantiate())

func _ready() -> void:
	self.load_level("1")

func _process(_delta: float) -> void:
	self.tick += 1
