extends Node2D
class_name Level

var currentRoom: Room
@export var startPosition: Node2D

func _ready() -> void:
	if self.currentRoom == null:
		self.currentRoom = self.get_child(0)
	$/root/Game/Explorer.position = self.startPosition.position

func _physics_process(_delta: float) -> void:
	var wave := self.currentRoom.currentWave()
	if wave != null:
		for enemy in wave.get_children():
			enemy._tick()
