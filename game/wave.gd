extends Node2D
class_name Wave

func _ready() -> void:
	self.get_parent().waves.append(self)
