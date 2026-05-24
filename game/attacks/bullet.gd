class_name Bullet
extends StaticBody2D

enum BulletKind {
	Defensive,
	Offensive
}


@export var direction: Vector2
@export var speed = 400
@export var kind: BulletKind


func _physics_process(delta: float) -> void:
	var collision = self.move_and_collide(self.direction * self.speed * delta)
	
	if collision == null:
		return
	
	var collider = collision.get_collider()
	if collider is Bullet:
		if self.kind == BulletKind.Defensive && collider.kind == BulletKind.Offensive:
			collider.queue_free()
		else:
			return
	elif collider.has_signal("hit_by_bullet"):
		collider.emit_signal("hit_by_bullet", self)
	self.queue_free()
