extends "res://Scripts/Cards/Focus_Spell.gd"
tool

const ATTACK_BUFF = 2

func _ready():
	node_name = "Rage"

func apply_effect_to_creature(creature_id):
	var creature_node = get_tree().get_current_scene().get_creature_by_id(creature_id)
	creature_node.add_one_turn_attack(ATTACK_BUFF)
	creature_node.add_one_turn_keyword("Indestructible")

func is_target_ok(target_id):
	return target_id >= 0 # only focus creatures
