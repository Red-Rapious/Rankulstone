extends "res://Scripts/Cards/Creature.gd"
tool

const INVOKE_NAME = "Frerot_Ludo"

func _ready():
	node_name = "Grosse_Berta"


func enter_battlefield_effect():
	var card_uniq_id = player.ask_new_uniq_id(true, INVOKE_NAME)
	global.get_tree().get_current_scene().add_card_to_board(true, INVOKE_NAME, card_uniq_id)
	player.self_creature_enter_battlefield(INVOKE_NAME)

	

func die_effect():
	for creature in get_tree().get_current_scene().get_node("All/Center/Board/Self_Board").get_children():
		if creature.node_name == INVOKE_NAME:
			player.kill_creature(creature.uniq_id)
			break
