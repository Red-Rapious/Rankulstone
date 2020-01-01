extends "res://Scripts/Cards/Focus_Spell.gd"
tool

const ATTACK_BUFF = 2

func _ready():
	node_name = "Rage"

func apply_effect_to_creature(creature_id):
	player.add_one_turn_attack(creature_id, ATTACK_BUFF)
	player.add_one_turn_keyword(creature_id, "Indestructible")

func is_target_ok(target_id):
	return target_id >= 0 # only focus creatures
