extends Control

func _ready():
	apply_options()
	update_player_profil()
	
func apply_options():
	$All/Center/Options_List/VBoxContainer/CheckBox.pressed = options.options_dico["toggle_fullscreen"]

func _on_Button_pressed():
	options.save_options()
	
func update_player_profil():
	$All/Center/Player_infos/Pseudo.text = "Pseudo : "+global.self_pseudo
	$All/Center/Player_infos/Icon_Button.icon_number = global.self_icon
	$All/Center/Player_infos/Icon_Button.set_texture()


func _on_Update_profil_Button_pressed():
	global.change_informations = true
	get_tree().change_scene("Scenes/Menus/First_time_Screen.tscn")


func _on_Attention_toggled(button_pressed):
	options.options_dico["request_attention"] = button_pressed


func _on_Fullscreen_toggled(button_pressed):
	options.options_dico["toggle_fullscreen"] = button_pressed
