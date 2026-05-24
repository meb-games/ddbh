extends StaticBody2D

@export var color: Color = Color.RED

func _init() -> void:
	self.hit_by_bullet.connect(self._hit_by_bullet)

func _ready() -> void:
	$TextureRect.modulate = color

signal hit_by_bullet
func _hit_by_bullet(bullet: Bullet):
	bullet.queue_free()
