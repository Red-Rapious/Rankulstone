extends "res://Scripts/Cards/Spell.gd"
tool

const ADD_MANA_VALUE = 2

func _ready():
	node_name = "Larme_de_la_deesse"

func apply_effect():
	player.add_self_mana(ADD_MANA_VALUE)