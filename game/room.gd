extends Node2D
class_name Room

var waves: Array[Wave] = []
var current_wave: int = 0

func currentWave() -> Wave:
	return self.waves[self.current_wave]


func _ready() -> void:
	if self.get_parent() is not Level:
		printerr("Rooms must be children of a level")
	self.currentWave().start()
		
func _on_explorer_exit() -> void:
	for enemy in self.currentWave().get_children():
		enemy._stop()

func _on_enemy_die() -> void:
	if self.currentWave().get_child_count() == 0:
		self.current_wave += 1
		self.currentWave().start()
