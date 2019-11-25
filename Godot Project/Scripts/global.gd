extends Node

enum {PLAY, ATTACK}

const VERSION = "0.0.1"
var information_loaded = false
var favorite_icon = 0
var win = false

var self_pseudo = "No pseudo detected"
var opponent_pseudo = "No pseudo detected"

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game()
		get_tree().quit()