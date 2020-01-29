extends Control

func _ready():
	apply_options()
	update_player_profil()
	
func apply_options():
	$All/Center/Options_List/VBoxContainer/Fullscreen.pressed = options.options_dico["toggle_fullscreen"]
	$All/Center/Options_List/VBoxContainer/Attention.pressed = options.options_dico["request_attention"]
	$All/Center/Options_List/VBoxContainer/Border.pressed = options.options_dico["show_attack_border"]
	$All/Center/Options_List/VBoxContainer/Camera_shake.pressed = options.options_dico["camera_shake"]

func _on_Button_pressed():
	options.save_options()
	
func update_player_profil():
	$All/Center/Player_infos/Pseudo.text = "Pseudo : "+global.self_pseudo
	$All/Center/Player_infos/Icon_Button.icon_number = global.self_icon
	$All/Center/Player_infos/Icon_Button.set_texture()


func _on_Update_profil_Button_pressed():
	global.change_informations = true
	get_tree().change_scene("Scenes/Menus/First_time_Screen.tscn")





# Options checkbox
func _on_Attention_toggled(button_pressed):
	options.options_dico["request_attention"] = button_pressed

func _on_Fullscreen_toggled(button_pressed):
	options.options_dico["toggle_fullscreen"] = button_pressed

func _on_Border_toggled(button_pressed):
	options.options_dico["show_attack_border"] = button_pressed

func _on_Camera_shake_toggled(button_pressed):
	options.options_dico["camera_shake"] = button_pressed
