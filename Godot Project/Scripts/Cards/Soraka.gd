extends "res://Scripts/Cards/Creature.gd"

const HEAL_VALUE = 3

func enter_battlefield_effect():
	# change this later
	for creature in get_node("../").get_children():
		player.change_creature_hp(creature.uniq_id, HEAL_VALUE)