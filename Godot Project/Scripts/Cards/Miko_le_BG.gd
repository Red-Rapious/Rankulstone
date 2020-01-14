extends "res://Scripts/Cards/Creature.gd"
tool

func _ready():
	node_name = "Miko_le_BG"

func create_drop_dico():
	var has_defenseur = "Defenseur" in keywords or "Defenseur" in one_turn_keywords
	
	randomize()
	var does_double_damages = bool(randi() % 2) # random bool
	var this_fight_attack = attack + one_turn_attack
	
	if does_double_damages:
		this_fight_attack *= 2
	
	if on_board:
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":1, "card_name": node_name, "can_attack": can_attack and not has_defenseur, "attack_value": this_fight_attack, "is_self_side": is_self_side}
	else:
		return {"mana_cost": MANA_COST,"uniq_id": uniq_id,"drag_type":0, "card_name": node_name, "can_attack": false, "attack_value": 0, "is_self_side": false}
# end
