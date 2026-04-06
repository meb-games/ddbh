extends Area2D

@export var out: Node2D

signal hit_by_explorer

func _init() -> void:
	self.hit_by_explorer.connect(func(explorer):
		get_viewport().get_camera_2d().position = self.out.position + (get_viewport().get_visible_rect().size / 2)
		explorer.position = self.out.position
		self.out.get_parent().get_parent().currentRoom = self.out.get_parent()
	)

func _ready() -> void:
	if self.get_parent() is not Room:
		printerr("Portals must be children of a room")
	if self.out.get_parent() is not Room:
		printerr("Portal outputs must be children of a room")
