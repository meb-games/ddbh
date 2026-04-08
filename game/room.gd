extends Node2D
class_name Room

var waves: Array[Wave] = []
var current_wave: int = 0

func currentWave() -> Wave:
    return self.waves[self.current_wave]


func _ready() -> void:
    if self.get_parent() is not Level:
        printerr("Rooms must be children of a level")


func _on_explorer_exit() -> void:
    for enemy in self.currentWave().get_children():
        enemy._stop()
