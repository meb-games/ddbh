extends Node

@export var first: Room
@export var second: Room

signal hit_by_explorer

func _init() -> void:
	self.hit_by_explorer.connect(func(_explorer):
		get_viewport().get_camera_2d().position = second.position + (get_viewport().get_visible_rect().size / 2)
		self.get_parent().currentRoom = second
	)

func _ready() -> void:
	self.position = first.position
	self.position.x += get_viewport().get_visible_rect().size.x
