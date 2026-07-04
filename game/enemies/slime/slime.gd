extends Enemy
class_name Slime

const HOP_DISTANCE := 60.0

func _act(_explorer: CharacterBody2D):
	var movx = float(randi_range(-1, 1))
	var movy = float(randi_range(-1, 1))
	
	self.move_by(Vector2(movx, movy), self.HOP_DISTANCE)

func _hit_by_explorer(_explorer: Explorer):
	$/root/Game/Explorer._hit_by_attack(self)
