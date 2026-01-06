extends Control

func resume():
	get_tree().paused = false
	visible = false
	
func pause():
	get_tree().paused = true
	visible = true
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ingame_pause"):
		if get_tree().paused:
			resume()
		else:
			pause()



func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
