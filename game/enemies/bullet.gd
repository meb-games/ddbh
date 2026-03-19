extends StaticBody2D
class_name Bullet

@export var direction: Vector2
@export var speed = 400


func _physics_process(delta: float) -> void:
	var collision = self.move_and_collide(self.direction * self.speed * delta)
	
	if collision == null:
		return
	
	var collider = collision.get_collider()
	if collider.has_signal("hit_by_bullet"):
		collider.emit_signal("hit_by_bullet", self)
	self.queue_free()
