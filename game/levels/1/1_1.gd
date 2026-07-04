extends Room

func _ready() -> void:
	$PortalOut.enable()
	#$/root/Game/Explorer/Ammo.set_value.emit(-1)
	#$/root/Game/UI/Ammo.visible = false
