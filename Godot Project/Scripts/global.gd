extends Node

enum {PLAY, ATTACK} # differents drag types
enum {DRAG_TYPE, CARD_NAME, NODE_NAME, CAN_ATTACK, ATTACK_VALUE} # the array passed with d&d description

const VERSION = "0.0.1"
var information_loaded = false # if it has been set by the First time screen
var favorite_icon = 0
var win = false

var self_pseudo = "No pseudo detected"
var opponent_pseudo = "No pseudo detected"

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game() # say to the opponent we resign
		get_tree().quit()