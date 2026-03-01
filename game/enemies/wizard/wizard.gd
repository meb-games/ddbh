extends Enemy

# The angle (in radians) that bullets are rotated by.
const BULLET_OFFSET = (1.0/8.0) * PI

func _act(explorer: CharacterBody2D):
	var bulletDirection := self.position.direction_to(explorer.position)
	for i in range(-2, 3):
		var bullet = self.spawn_attack()
		bullet.direction = bulletDirection.rotated(i * BULLET_OFFSET)
