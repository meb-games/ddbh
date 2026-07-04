extends Label

@onready var ammo = $/root/Game/Explorer/Ammo

func _ready() -> void:
	ammo.set_value.connect(self.setText)
	self.setText(ammo.INITIAL)

func setText(amount: int):
	self.text = "Ammo: " + str(amount) + "/" + str(ammo.INITIAL)
