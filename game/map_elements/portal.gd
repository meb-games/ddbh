extends Area2D

@export var out: Node2D

const COLLISION_LAYER := 1 << 6

func _init() -> void:
	self.body_entered.connect(func(body):
		body.collision_layer &= ~COLLISION_LAYER

		body.position = self.out.position + self.out_room().position
		if body is Explorer:
			self.out_room().activate()
			self.in_room()._on_explorer_exit()

		await get_tree().create_timer(.5).timeout
		if body != null:
			body.collision_layer |= COLLISION_LAYER
	)

func enable():
	self.collision_mask = COLLISION_LAYER
func disable():
	self.collision_mask = 0

func in_room() -> Room:
	return self.get_parent()
func out_room() -> Room:
	return self.out.get_parent()
func level() -> Level:
	return self.in_room().get_parent()

func _ready() -> void:
	if self.get_parent() is not Room:
		printerr("Portals must be children of a room")
	if self.out.get_parent() is not Room:
		printerr("Portal outputs must be children of a room")
