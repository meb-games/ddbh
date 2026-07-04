extends Node2D

var tick := 0
@export var level_to_load: int = 1

func load_level(levelId: int) -> void:
	if self.has_node("Level"):
		$Level.queue_free()
	var level = load("res://game/levels/%s.tscn" % levelId).instantiate()
	level.name = "Level"
	$/root/Game.add_child(level)

func _ready() -> void:
	self.load_level(level_to_load)

func _process(_delta: float) -> void:
	self.tick += 1
