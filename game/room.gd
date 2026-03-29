extends Node2D
class_name Room

var waves: Array[Wave] = []
var current_wave: int = 0

func currentWave() -> Wave:
	return self.waves[self.current_wave]
