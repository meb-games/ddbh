extends Node2D

@export var MAGE_SCENE: PackedScene
@export var WIZARD_SCENE: PackedScene

func _ready() -> void:
	var mage = WIZARD_SCENE.instantiate()
	# is trying to call update healthbar ui but dont know how to make function global and as stated below too tired to proberly write
	$HealthBar.value = 10 #NEEDS TO BE CHANGED IM JUST TOO TIRED TO PROBERELY WRITE
	mage.position.x += 100
	mage.position.y += 100
	add_child(mage)
