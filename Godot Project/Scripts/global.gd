extends Node

const VERSION = "0.0.1"
var information_loaded = false
var favorite_icon = 0
var win = false

var self_pseudo = "RedRapious"
var opponent_pseudo = "RedRapious"

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game()
		get_tree().quit()