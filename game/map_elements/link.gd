extends Node

@export var first: Node2D
@export var second: Node2D

signal hit_by_explorer

func _init() -> void:
	self.hit_by_explorer.connect(func(_explorer):
		get_viewport().get_camera_2d().position = second.position
	)

func _ready() -> void:
	self.position = first.position
	self.position.x += get_viewport().get_visible_rect().size.x
