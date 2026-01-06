extends Enemy

func _fire(player: CharacterBody2D):
	var bulletDirection := self.position.direction_to(player.position)
	var bullet := self.BULLET.instantiate();
	bullet.motion = bulletDirection
	self.add_child(bullet)
