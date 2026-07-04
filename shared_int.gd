extends Node
class_name SharedInt

signal set_value(amount: int)
signal change(amount: int)

func _init() -> void:
	self.set_value.connect(func(amount):
		self._value = amount
	)
	self.change.connect(func(amount):
		self.set_value.emit(self._value + amount)
	)

func _ready():
	self._value = self.INITIAL

@export var INITIAL: int = 10
var _value: int

func value() -> int:
	return self._value
