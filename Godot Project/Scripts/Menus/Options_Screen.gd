extends Control

func _ready():
	apply_options()
	
func apply_options():
	$VBoxContainer/ScrollContainer/VBoxContainer/CheckBox.pressed = options.options_dico["toggle_fullscreen"]

func _on_Button_pressed():
	options.save_options()

func _on_CheckBox_toggled(pressed):
	options.options_dico["toggle_fullscreen"] = pressed
