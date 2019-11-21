extends VBoxContainer

func _ready():
	player.connect("self_library_changed", self, "_on_self_library_changed")
	player.connect("opponent_library_changed", self, "_on_opponent_library_changed")
	player.connect("self_pv_changed", self, "_on_self_pv_changed")
	player.connect("opponent_pv_changed", self, "_on_opponent_pv_changed")
	player.connect("self_end_of_turn", self, "_on_self_end_of_turn")
	player.connect("opponent_end_of_turn", self, "_on_opponent_end_of_turn")
	_on_self_library_changed() # initialize self hand
	_on_opponent_library_changed() # initialize the opponent hand
	
	if not player.your_turn:
		_on_self_end_of_turn()
	
func _on_self_library_changed():
	$Self_Library.text = "Cartes restantes : "+str(len(player.library)) +"\n"+str(player.self_pv)
	
func _on_opponent_library_changed():
	$Opponent_Library.text = "Cartes restantes : "+str(player.opponent_library_size) +"\nPV : "+str(player.opponent_pv)
	
func _on_self_pv_changed():
	$Self_Library.text = "Cartes restantes : "+str(len(player.library)) +"\n"+str(player.self_pv)
	
func _on_opponent_pv_changed():
	$Opponent_Library.text = "Cartes restantes : "+str(player.opponent_library_size) +"\nPV : "+str(player.opponent_pv)

func _on_Right_Button_pressed():
	if player.your_turn:
		player.end_of_turn()
		
func _on_self_end_of_turn():
	$Right_Button.text = "En attente..."
	$Right_Button.disabled = true
	
func _on_opponent_end_of_turn():
	$Right_Button.text = "Fin de tour"
	$Right_Button.disabled = false
