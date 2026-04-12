extends Area2D

@export var out: Node2D

func _init() -> void:
	self.body_entered.connect(func(explorer):
		explorer.collision_layer = explorer.collision_layer & (~16)

		var viewport = get_viewport()
		viewport.get_camera_2d().position = self.out_room().position + (viewport.get_visible_rect().size / 2)
		$/root/Game/UI.position = self.out_room().position
		explorer.position = self.out.position + self.out_room().position
		self.level().currentRoom = self.out_room()
		self.in_room()._on_explorer_exit()

		await get_tree().create_timer(.5).timeout
		if explorer != null:
			explorer.collision_layer = explorer.collision_layer | 16
	)

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
