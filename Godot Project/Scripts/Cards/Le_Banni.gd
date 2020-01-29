extends "res://Scripts/Cards/Focus_Spell.gd"
tool

const PV_BUFF = -5
const ATTACK_BUFF = -5

func _ready():
	node_name = "Le_Banni"

func apply_effect_to_creature(creature_id):
	player.add_attack(creature_id, ATTACK_BUFF)
	player.add_pv_to_creature(creature_id, PV_BUFF)

func is_target_ok(target_id):
	return target_id >= 0
