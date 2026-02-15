extends Enemy

var offsetTop := Vector2(-25, -25)
var offsetBottom := Vector2(-25, 25)

func _attack(player: CharacterBody2D):
	var bulletDirection := self.position.direction_to(player.position).normalized()
	var bullet = self.spawnAttack()
	bullet.direction = bulletDirection
