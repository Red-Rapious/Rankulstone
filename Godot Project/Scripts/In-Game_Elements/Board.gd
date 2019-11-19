extends VBoxContainer

signal card_dropped

func can_drop_data(_pos, node_name):
	"""
	When an item is dragged on top of the board, this function is called.
	Return true if item can be dropped, false if it can't
	"""
	
	# TODO : change to a cleanest version
	if node_name != "-1":
		return get_node("../Self_Hand/"+node_name).MANA_COST <= player.mana # temporary mana check
	else:
		return false
	
func drop_data(_pos, node_name):
	# called when a card if dropped
	emit_signal("card_dropped", node_name)