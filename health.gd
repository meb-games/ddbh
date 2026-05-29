extends Node

signal set_value(amount: int)
signal change(amount: int)

func _init() -> void:
	self.set_value.connect(func(amount):
		self._health = amount
	)
	self.change.connect(func(amount):
		self.set_value.emit(self._health + amount)
	)

@export var MAX_HEALTH: int = 10
var _health: int = MAX_HEALTH

func value() -> int:
	return self._health
