extends Node2D
class_name Level

var currentRoom: Room
@export var startPosition: Node2D

func _ready() -> void:
	if self.currentRoom == null:
		self.currentRoom = self.get_child(0)
	$/root/Game/Explorer.position = self.startPosition.position

func _physics_process(delta: float) -> void:
	for enemy in self.currentRoom.currentWave().get_children():
		enemy._tick()
