extends Node2D

@export var bulletOffset := (1.0/8.0) * PI
@export var direction: Vector2
@export var speed := 200

@export var growthSpeed := 100.0
@export var radius := 50.0

var bullets

func _ready() -> void:
	self.bullets = [$Bullet1, $Bullet2, $Bullet3, $Bullet4, $Bullet5]

func _physics_process(delta: float) -> void:
	self.translate(direction * speed * delta)
	self.radius += growthSpeed * delta
	
	var i = -2
	for bullet in bullets:
		if bullet != null:
			bullet.position = self.direction.rotated(i  * self.bulletOffset) * self.radius
		i += 1
