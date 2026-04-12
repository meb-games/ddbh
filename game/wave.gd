extends Node2D
class_name Wave

var og_positions = []

func _ready() -> void:
	self.get_parent().waves.append(self)
	for child in self.get_children():
		og_positions.append(child.position)
		child.global_position = Vector2(-100, 100)

func start():
	for idx in range(0, self.get_child_count()):
		self.get_child(idx).position = og_positions[idx]
		og_positions = null
