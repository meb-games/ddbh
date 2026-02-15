extends Enemy

static var WIZARD_BULLET: PackedScene = preload("res://game/enemy/wizard/bullet_pattern.tscn")

var offsetTop := Vector2(-25, -25)
var offsetBottom := Vector2(-25, 25)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _fire(player: CharacterBody2D):
	var bulletDirection := self.position.direction_to(player.position).normalized()
	var bullet = WIZARD_BULLET.instantiate()
	bullet.direction = bulletDirection
	self.add_child(bullet)
