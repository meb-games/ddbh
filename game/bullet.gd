extends Area2D

@export var motion: Vector2
@export var speed = 400

func _ready() -> void:
	self.connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_hit"):
		body.take_hit(1)
	queue_free()


func _physics_process(delta: float) -> void:
	self.translate(motion * speed * delta)
