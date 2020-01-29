extends "res://Scripts/Cards/Creature.gd"

const HEAL_VALUE = 3

func enter_battlefield_effect():
	# change this later
	for creature in get_node("../").get_children():
		if creature.uniq_id != uniq_id: # if not this card
			player.add_pv_to_creature(creature.uniq_id, HEAL_VALUE)
