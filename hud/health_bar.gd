extends ProgressBar

func _ready() -> void:
	$/root/Game/Explorer/Health.set_value.connect(func(val):
		self.value = val
	)
