extends "res://Scripts/Cards/Spell.gd"
tool

const DAMAGE = 3

func _ready():
	node_name = "Tourbilol"

func apply_effect():
	for creature in player.get_tree().get_current_scene().get_node("All/Center/Board/Opponent_Board").get_children():
		player.add_pv_to_creature(creature.uniq_id, -DAMAGE)
		
	for creature in player.get_tree().get_current_scene().get_node("All/Center/Board/Self_Board").get_children():
		player.add_pv_to_creature(creature.uniq_id, -DAMAGE)