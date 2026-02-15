extends Enemy

var bulletsToSpawn = 0
var bulletDirection: Vector2
var mageFire: Timer

func _ready():
	self.mageFire = $MageFire
	self.mageFire.one_shot = true
	self.mageFire.connect(
		'timeout',
		func():
			var bullet = self.spawnAttack()
			bullet.direction = bulletDirection
			
			self.bulletsToSpawn -= 1
			if self.bulletsToSpawn > 0:
				mageFire.start()
	)

func _attack(explorer: CharacterBody2D):
	self.bulletsToSpawn = 4
	self.bulletDirection = self.position.direction_to(explorer.position)
	self.mageFire.start()
