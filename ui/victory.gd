extends Control

func next_level():
	var game = $/root/Game
	game.level_to_load += 1
	game.load_level(game.level_to_load)
	self.visible = false
