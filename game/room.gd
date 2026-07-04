extends Node2D
class_name Room

@export var final_room := false

var waves: Array[Wave] = []
var current_wave: int = 0
var enemy_died := false

func currentWave() -> Wave:
    if self.current_wave == len(self.waves):
        return null
    return self.waves[self.current_wave]

func level() -> Level:
    return self.get_parent()
    
func activate():
    var viewport = get_viewport()
    viewport.get_camera_2d().position = self.position + (viewport.get_visible_rect().size / 2)
    $/root/Game/UI.position = self.position
    self.level().currentRoom = self



func _ready() -> void:
    if self.get_parent() is not Level:
        printerr("Rooms must be children of a level")
    if self.has_node("PortalOut"):
        $PortalOut.disable()
    self.currentWave().start()
    
func _process(_delta: float) -> void:
    if self.enemy_died:
        self.enemy_died = false
        if self.currentWave().get_child_count() == 0:
            self.current_wave += 1
            if self.current_wave == len(self.waves):
                self._on_all_waves_defeated()
            else:
                self.currentWave().start()

func _on_explorer_exit() -> void:
    var wave := self.currentWave()
    if wave != null:
        for enemy in wave.get_children():
            enemy._stop()

func _on_enemy_die() -> void:
    self.enemy_died = true

func _on_all_waves_defeated():
    if self.has_node("PortalOut"):
        $PortalOut.enable()
    elif self.final_room:
        $/root/Game/UI/Victory.visible = true
