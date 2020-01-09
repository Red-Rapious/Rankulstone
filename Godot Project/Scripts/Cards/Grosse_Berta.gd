extends "res://Scripts/Cards/Creature.gd"
tool

const INVOKE_NAME = "Frerot_Ludo"

var recall = true


func _ready():
	node_name = "Grosse_Berta"


func enter_battlefield_effect():
	var card_uniq_id = player.ask_new_uniq_id(true, INVOKE_NAME)
	global.get_tree().get_current_scene().add_card_to_board(true, INVOKE_NAME, card_uniq_id)
	player.self_creature_enter_battlefield(INVOKE_NAME, card_uniq_id)
	

func die():
	"""
	Called when this creature die.
	The only way to queue_free()
	"""
	if recall:
		die_effect()
		
	emit_signal("quit_battlefield")
	player.creature_died(create_drop_dico())
	queue_free()


func die_effect():
	var board
	if is_self_side:
		board = get_tree().get_current_scene().get_node("All/Center/Board/Self_Board")
	else:
		board = get_tree().get_current_scene().get_node("All/Center/Board/Opponent_Board")
		
	for creature in board.get_children():
		if creature.node_name == INVOKE_NAME:
			creature.die_without_recall()
			player.kill_creature(creature.uniq_id)
			break

func die_without_recall():
	recall = false