extends TextureButton

func can_drop_data(_pos, data):
	""" --> bool
	When a card is dragged on top of the opponent UI group, this function is called.
	Return true if item can be dropped, false if it can't, 
	depending on the turn and if the card as already attacked
	"""

	return data["is_self_side"] and data["drag_type"]==global.ATTACK and data["can_attack"] and player.your_turn 
	
func drop_data(_pos, data):
	get_parent().emit_signal("card_attacked", data)
