extends Node

const VERSION = "0.0.1"
var is_player_information_loaded = false
var player_pseudo = ""
var favorite_icon = 0
var win = false

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game()
		get_tree().quit()