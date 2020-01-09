extends "res://Scripts/Cards/Creature.gd"
tool

const INVOKE_NAME = "Petite_merde_violette"

func _ready():
	node_name = "Portail_de_ZZRot"

func tour_begin_effect():
	var card_uniq_id = player.ask_new_uniq_id(true, INVOKE_NAME)
	global.get_tree().get_current_scene().add_card_to_board(true, INVOKE_NAME, card_uniq_id)
	player.self_creature_enter_battlefield(INVOKE_NAME, card_uniq_id)