extends "res://Scripts/Cards/Spell.gd"
tool

const PV_HEAL = 5

func apply_effect():
	player.add_self_pv(PV_HEAL)
