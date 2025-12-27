extends Node2D

@export var MAGE_SCENE: PackedScene

func _ready() -> void:
    var mage = MAGE_SCENE.instantiate()
    mage.position.x += 100
    mage.position.y += 100
    add_child(mage)
