extends Control

func _ready() -> void:
	# Load the game scene when the play button is pressed
	$Play.connect(
		"pressed",
		func(): self.get_tree().change_scene_to_file("res://game.tscn")
	)
