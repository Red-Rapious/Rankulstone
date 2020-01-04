extends "res://Scripts/Cards/Focus_Spell.gd"
tool

func _ready():
	node_name = "Tentative_de_reconnection"

func is_target_ok(target_id):
	return target_id >= 0 # only focus creatures
	
func apply_effect_to_creature(creature_id):
	player.add_one_turn_keyword(creature_id, "Indestructible")
