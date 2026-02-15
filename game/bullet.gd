extends Area2D

@export var direction: Vector2
@export var speed = 400

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_class("Explorer"):
		body.on_hit_by_bullet()


func _physics_process(delta: float) -> void:
	self.translate(self.direction * self.speed * delta)
