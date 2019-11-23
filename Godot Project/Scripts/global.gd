extends Node

const VERSION = "0.0.1"
var is_player_information_loaded = false
var favorite_icon = 0
var win = false

var self_pseudo = ""
var opponent_pseudo = ""

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game()
		get_tree().quit()