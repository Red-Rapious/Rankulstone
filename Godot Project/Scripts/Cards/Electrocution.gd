tool
extends "res://Scripts/Cards/Focus_Spell.gd"

const DAMAGE = 3

func _ready():
	node_name = NAME

func apply_effect_to_creature(creature_id):
	if creature_id >= 0:
		player.add_pv_to_creature(creature_id,-DAMAGE)
	elif creature_id == OPPONENT:
		player.rpc("add_self_pv", -DAMAGE)
	elif creature_id == SELF:
		player.add_self_pv(-DAMAGE)
