extends Node2D
class_name Level

var currentRoom: Room

func _ready() -> void:
	if self.currentRoom == null:
		self.currentRoom = self.get_child(0)

func _physics_process(delta: float) -> void:
	for enemy in self.currentRoom.currentWave().get_children():
		enemy._tick()
