extends Area2D

@export var motion: Vector2
@export var speed = 400

func _ready() -> void:
	self.connect('body_entered', func(_area: Node2D): self.get_tree().change_scene_to_file("res://game_over.tscn"))

func _physics_process(delta: float) -> void:
	self.translate(motion * speed * delta)
