extends VBoxContainer

signal card_dropped

func can_drop_data(_pos, node_name):
	# TODO : change to a cleanest version
	return get_node("../Self_Hand/"+node_name).MANA_COST <= player.mana
	
func drop_data(_pos, node_name):
	emit_signal("card_dropped", node_name)