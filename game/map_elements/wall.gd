extends StaticBody2D

@export var color: Color = Color.RED

func _ready() -> void:
	$TextureRect.modulate = color

signal hit_by_bullet
