extends VBoxContainer

signal card_dropped


func can_drop_data(_pos, data):
	"""
	When an card is dragged on top of the board, this function is called.
	Return true if item can be dropped, false if it can't
	"""

	
	if data["drag_type"]==global.PLAY:
		#var card=get_node("../Self_Hand/"+str(data["uniq_id"]))
		#var card=get_node("../Self_Hand/"+data["node_name"])
		return  player.your_turn and data["mana_cost"] <= player.self_mana
	else:
		return false
	
func drop_data(_pos, card_dico):
	# called when a card if dropped
	emit_signal("card_dropped", card_dico)