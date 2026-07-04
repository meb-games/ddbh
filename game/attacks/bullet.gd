class_name Bullet
extends StaticBody2D

enum BulletTeam {
	Explorer,
	Enemy
}
enum BulletKind {
	Defensive,
	Offensive
}


@export var direction: Vector2
@export var speed = 400
@export var kind: BulletKind
@export var team: BulletTeam


func _physics_process(delta: float) -> void:
	var collision = self.move_and_collide(self.direction * self.speed * delta)
	
	if collision != null:
		var collider = collision.get_collider()
		if collider.has_signal("hit_by_bullet"):
			collider.emit_signal("hit_by_bullet", self)
		else:
			self.queue_free()

signal hit_by_bullet
func _hit_by_bullet(bullet: Bullet):
	if self.kind == BulletKind.Offensive && bullet.kind == BulletKind.Defensive:
		self.queue_free()
		bullet.queue_free()
