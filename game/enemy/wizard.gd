extends Enemy

var offsetScale := 100
var offsetTop := Vector2(-.5, -.5) * offsetScale
var offsetBottom := Vector2(-.5, .5) * offsetScale

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _fire(player: CharacterBody2D):
	var bulletDirection := self.position.direction_to(player.position)
	for i in range(1, 3):
		#nolint
		var bulletUp = self.BULLET.instantiate()
		bulletUp.motion = bulletDirection
		bulletUp.position += offsetTop * i
		self.add_child(bulletUp)
	for i in range(1, 3):
		var bulletBottom = self.BULLET.instantiate()
		bulletBottom.motion = bulletDirection
		bulletBottom.position += offsetBottom * i
		self.add_child(bulletBottom)
	var bullet = self.BULLET.instantiate()
	bullet.motion = bulletDirection
	self.add_child(bullet)
