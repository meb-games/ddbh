extends Node2D

@export var MAGE_SCENE: PackedScene
@export var WIZARD_SCENE: PackedScene

func _ready() -> void:
	var mage = WIZARD_SCENE.instantiate()
	mage.position.x += 100
	mage.position.y += 100
	#add_child(mage)
