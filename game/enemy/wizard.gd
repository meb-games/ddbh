extends Enemy

var offsetTop := Vector2(-25, -25)
var offsetBottom := Vector2(-25, 25)

func _on_fire(player: CharacterBody2D):
	var bulletDirection := self.position.direction_to(player.position).normalized()
	var bullet = self.spawnBullet()
	bullet.direction = bulletDirection
