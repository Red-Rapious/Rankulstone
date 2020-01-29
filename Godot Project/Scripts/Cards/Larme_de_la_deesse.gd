extends "res://Scripts/Cards/Spell.gd"
tool

const ADD_MANA_VALUE = 1

func _ready():
	node_name = "Larme_de_la_deesse"

func apply_effect():
	player.set_self_mana_max(player.self_mana + ADD_MANA_VALUE)
