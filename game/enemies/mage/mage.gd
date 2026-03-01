extends Enemy

var bulletsToSpawn = 0
var bulletDirection: Vector2
var mage_fire: Timer

func _ready():
	self.mage_fire = $MageFire
	self.mage_fire.one_shot = true
	self.mage_fire.connect(
		'timeout',
		func():
			var bullet = self.spawn_attack()
			bullet.direction = bulletDirection
			
			self.bulletsToSpawn -= 1
			if self.bulletsToSpawn > 0:
				self.mage_fire.start()
	)

func _act(explorer: CharacterBody2D):
	self.bulletsToSpawn = 4
	self.bulletDirection = self.position.direction_to(explorer.position)
	self.mage_fire.start()
