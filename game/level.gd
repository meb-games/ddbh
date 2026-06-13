extends Node2D
class_name Level

var currentRoom: Room
@export var startPosition: Node2D

func _ready() -> void:
	$/root/Game/Explorer.position = self.startPosition.position
	self.get_child(0).activate()

func _physics_process(_delta: float) -> void:
	var wave := self.currentRoom.currentWave()
	if wave != null:
		for enemy in wave.get_children():
			enemy._tick()
