extends "res://Scripts/Cards/Focus_Spell.gd"
tool

const ATTACK_BUFF = 1

func _ready():
	node_name = "Guinsoo"
	
func is_target_ok(target_id):
	return target_id >= 0
	
func apply_effect_to_creature(creature_id):
	player.add_keyword(creature_id, "Guinsoo")
	player.add_attack(creature_id, ATTACK_BUFF)
