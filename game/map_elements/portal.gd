extends Area2D

@export var out: Node2D

func _init() -> void:
    self.body_entered.connect(func(explorer):
        explorer.collision_layer = explorer.collision_layer & (~16)
        
        var viewport = get_viewport()
        viewport.get_camera_2d().position = self.out.get_parent().position + (viewport.get_visible_rect().size / 2)
        $/root/Game/UI.position = self.out.get_parent().position
        explorer.position = self.out.position + self.out.get_parent().position
        self.out.get_parent().get_parent().currentRoom = self.out.get_parent()
        
        await get_tree().create_timer(2.0).timeout
        if explorer != null:
            explorer.collision_layer = explorer.collision_layer | 16
    )

func _ready() -> void:
    if self.get_parent() is not Room:
        printerr("Portals must be children of a room")
    if self.out.get_parent() is not Room:
        printerr("Portal outputs must be children of a room")
