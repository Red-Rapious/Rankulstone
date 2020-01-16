extends Node

enum {PLAY, ATTACK} # differents drag types
#enum {DRAG_TYPE, CARD_NAME, NODE_NAME, CAN_ATTACK, ATTACK_VALUE, IS_SELF_SIDE} # the array passed with d&d description
enum {SELF_CREATURE_DATA, OPPONENT_CREATURE_DATA} # for fight data, an array will be passed, containing both creatures data

var card_index = [
"Larme_de_la_deesse",
"Reproduction_imparfaite",
"Miko_le_BG",
"Grosse_Berta",
"Tourbilol",
"Le_Banni",
"Insulte_pas_mature",
"Portail_de_ZZRot",
"Mme_Jean",
"Toujours_la_pour_toi",
"Julien_OTP_Anivia",
"Tentative_de_reconnection",
"Julien_OTP_Kayle",
"Rage",
"Range_top",
"Electrocution",
"Flash_kick",
"Soin",
"Sylas",
"Soraka",
"Sbire_mage",
"Sbire_canon", 
"Super_sbire", 
"Vol"
]

const VERSION = "0.0.5"
var information_loaded = false # if it has been set by the First time screen
var change_informations = false

var win = false
var opponent_surrend = false

var self_icon = 0
var opponent_icon = 0
var self_pseudo = "No pseudo detected"
var opponent_pseudo = "No pseudo detected"

func _ready():
	card_index.sort()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		network.quit_game() # say to the opponent we resign
		#get_tree().quit()
		
		
func get_creature_by_id(creature_id: int):
	if get_tree().get_current_scene().name == "Battle_Screen":
		return get_tree().get_current_scene().get_creature_by_id(creature_id)
		
