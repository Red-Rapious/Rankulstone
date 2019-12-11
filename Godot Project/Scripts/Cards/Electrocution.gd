tool
extends "res://Scripts/Cards/Focus_Spell.gd"

const DAMAGE = 3

func _ready():
	node_name = NAME

func apply_effect_to_creature(creature_id):
	player.change_creature_hp(creature_id,-DAMAGE)