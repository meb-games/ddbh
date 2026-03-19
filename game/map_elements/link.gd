class_name Link
extends Node

@export var first: Node
@export var second: Node

func _ready() -> void:
	$/root/Example/Camera2D.position.x += 1000
