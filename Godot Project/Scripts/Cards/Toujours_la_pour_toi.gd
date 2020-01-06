extends "res://Scripts/Cards/Spell.gd"
tool

const ATTACK_BUFF = 2
const PV_BUFF = 2

func _ready():
	node_name = "Toujours_la_pour_toi"

func apply_effect():
	for creature in get_node("../../../Board/Self_Board").get_children():
		player.add_one_turn_attack(creature.uniq_id, ATTACK_BUFF)
		player.add_one_turn_pv(creature.uniq_id, PV_BUFF)