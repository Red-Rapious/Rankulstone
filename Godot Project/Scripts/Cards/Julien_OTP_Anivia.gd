extends "res://Scripts/Cards/Creature.gd"
tool

func _ready():
	node_name = "Julien_OTP_Anivia"
	
func apply_effect_to_creature(creature_id):
	player.add_one_turn_keyword(creature_id, "Defenseur")
	
func is_target_ok(target_id):
	return target_id >= 0 # only focus creatures