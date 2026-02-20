extends Area2D
class_name Bullet

@export var direction: Vector2
@export var speed = 400

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_signal("hit_by_bullet"):
		body.emit_signal("hit_by_bullet", self)
		self.queue_free()


func _physics_process(delta: float) -> void:
	self.translate(self.direction * self.speed * delta)
