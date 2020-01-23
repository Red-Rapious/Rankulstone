extends "res://Scripts/Cards/Focus_Spell.gd"
tool

func _ready():
	node_name = "Rabadon"
	
	
func is_target_ok(target_id):
	return target_id >= 0
	
func apply_effect_to_creature(creature_id):
	var attack_buff = int((global.get_creature_by_id(creature_id).attack + global.get_creature_by_id(creature_id).one_turn_attack) /2)
	player.add_attack(creature_id, attack_buff)