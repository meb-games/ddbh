extends ProgressBar

func _ready() -> void:
	$/root/Game/Explorer.health_changed.connect(func(val):
		self.value = val
	)
