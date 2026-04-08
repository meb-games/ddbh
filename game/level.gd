@tool
extends Node2D
class_name Level

var currentRoom: Room
@export var startPosition: Node2D

func _ready() -> void:
	if Engine.is_editor_hint():
		pass
		# bad experiment to automatically draw borders around rooms in the level
		#for room in self.get_children():
			#print("meow" + room.name)
			#var frame = Panel.new()
			#var style = StyleBoxFlat.new()
			#style.set_border_width_all(1)
			#style.border_color = Color.AQUAMARINE
			#frame["theme_override_styles/panel"] = style
			#room.add_child(frame)
			#frame.owner = get_tree().edited_scene_root
	else:
		if self.currentRoom == null:
			self.currentRoom = self.get_child(0)
		$/root/Game/Explorer.position = self.startPosition.position

func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		for enemy in self.currentRoom.currentWave().get_children():
			enemy._tick()
