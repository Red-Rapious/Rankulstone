extends VBoxContainer

signal card_dropped


func can_drop_data(_pos, data):
	"""
	When an card is dragged on top of the board, this function is called.
	Return true if item can be dropped, false if it can't
	"""

	# TODO : change to a cleanest version
	if data[0]==global.PLAY:
		var card=get_node("../Self_Hand/"+data[1])
		return (not card.on_board) and player.your_turn and get_node("../Self_Hand/"+data[1]).MANA_COST <= player.self_mana # temporary mana check
	else:
		return false
	
func drop_data(_pos, data):
	# called when a card if dropped
	emit_signal("card_dropped", data[1])