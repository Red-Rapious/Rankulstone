extends VBoxContainer

func can_drop_data(_pos, mana_needed):
	return mana_needed <= player.mana
	
func drop_data(_pos, data):
	pass