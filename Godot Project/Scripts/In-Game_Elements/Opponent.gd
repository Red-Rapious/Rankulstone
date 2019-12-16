extends VBoxContainer

signal card_attacked

func _ready():
	player.connect("opponent_mana_changed", self, "_on_opponent_mana_changed")
	player.connect("opponent_mana_max_changed", self, "_on_opponent_mana_changed")
	network.connect("network_infos_get", self, "_on_network_infos_get")
	_on_network_infos_get()
	
	
# some label update stuff
func _on_network_infos_get():
	$Pseudo.text = global.opponent_pseudo
	
func _on_opponent_mana_changed():
	$Mana_bar.text = "Mana : "+str(player.opponent_mana)+"/"+str(player.opponent_mana_max)
	
	$Mana_bar/ProgressBar.max_value = player.opponent_mana_max
	$Mana_bar/ProgressBar.value = player.opponent_mana
	

func can_drop_data(_pos, data):
	""" --> bool
	When a card is dragged on top of the opponent UI group, this function is called.
	Return true if item can be dropped, false if it can't, 
	depending on the turn and if the card as already attacked
	"""
	
	return data["is_self_side"] and data["drag_type"]==global.ATTACK and data["can_attack"] and player.your_turn 
	
func drop_data(_pos, data):
	emit_signal("card_attacked", data)