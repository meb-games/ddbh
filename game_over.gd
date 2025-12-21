extends Node2D


func _ready() -> void:
	$PlayAgain.connect("button_up", func(): self.get_tree().change_scene_to_file("res://game.tscn"))
