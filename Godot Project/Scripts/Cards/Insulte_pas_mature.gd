extends "res://Scripts/Cards/Focus_Spell.gd"
tool

const ATTACK_BUFF = 2

func _ready():
	node_name = "Insulte_pas_mature"

func apply_effect_to_creature(creature_id):
	player.add_attack(creature_id, ATTACK_BUFF)
	player.add_keyword(creature_id, "Provocation")

func is_target_ok(target_id):
	return target_id >= 0