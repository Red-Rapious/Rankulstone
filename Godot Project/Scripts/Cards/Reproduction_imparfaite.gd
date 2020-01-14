extends "res://Scripts/Cards/Focus_Spell.gd"
tool

func _ready():
	node_name = "Reproduction_imparfaite"

func is_target_ok(target_id):
	return target_id >= 0
	
func apply_effect_to_creature(creature_id):
	"""
	TODO: enter battefield focus
	"""
	var copy_name = global.get_creature_by_id(creature_id).node_name
	
	var card_uniq_id = player.ask_new_uniq_id(true, copy_name)
	global.get_tree().get_current_scene().add_card_to_board(true, copy_name, card_uniq_id)
	player.self_creature_enter_battlefield(copy_name, card_uniq_id)
	
	global.get_creature_by_id(card_uniq_id).enter_battlefield_effect()
	
	player.add_pv_to_creature(card_uniq_id, -global.get_creature_by_id(card_uniq_id).pv+1)
	player.add_pv_max(card_uniq_id, -global.get_creature_by_id(card_uniq_id).pv_max+1)
	player.add_attack(card_uniq_id, -global.get_creature_by_id(card_uniq_id).attack+1)