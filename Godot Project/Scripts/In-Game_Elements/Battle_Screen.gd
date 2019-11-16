extends Control

func _ready():
	OS.window_fullscreen = true
	
func _process(delta):
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()