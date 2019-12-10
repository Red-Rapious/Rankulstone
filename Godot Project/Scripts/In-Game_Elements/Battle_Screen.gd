extends Control

var creature_focus_mode = false

func _ready():
	player.connect("opponent_creature_played", self, "_on_opponent_creature_played")
	player.connect("opponent_creature_died", self, "_on_opponent_creature_died")
	player.connect("self_hand_changed", self, "_on_self_hand_changed")
	player.connect("self_creature_fight", self, "_on_self_creature_fight")
	player.connect("self_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("opponent_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("ask_side_popup", self, "_on_ask_side_popup")
	#OS.window_fullscreen = true
	player.init()
	_on_self_hand_changed() # update hand
	
func _process(delta):
	# quit game if escape is pressed
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()


# some hand interactions methods
func load_hand():
	"""
	This function look at player.hand, and add the specifics nodes to the Control hand
	"""
	for card in player.hand:
		var scene = load("res://Scenes/Cards/"+card+".tscn")
		var scene_instance = scene.instance()
		$All/Center/Self_Hand.add_child(scene_instance)
		
func clean_hand():
	"""
	This function delete all nodes from the player's hand
	"""
	for node in $All/Center/Self_Hand.get_children():
		$All/Center/Self_Hand.remove_child(node)

func _on_self_hand_changed():
	# reset hand, by cleaning all and reloading the whole hand
	clean_hand()
	load_hand()




func _on_Board_card_dropped(card_dico):
	play_card_from_hand(card_dico["card_name"])
	
func add_card_to_board(self_side, card_name, card_uniq_id):
	"""
	A function that add a card to the board. If self_side is true, add it to your own hand.
	Else, add it to the opponent hand
	"""
	
	# instance card
	var scene = load("res://Scenes/Cards/"+card_name+".tscn")
	var scene_instance = scene.instance()
	
	scene_instance.play_card(card_uniq_id)
	scene_instance.is_self_side = self_side
	
	# add instance to the board
	if self_side:
		$All/Center/Board/Self_Board.add_child(scene_instance)
	else:
		$All/Center/Board/Opponent_Board.add_child(scene_instance)
		
		
		
	

func play_card_from_hand(node_name: String):
	"""
	A function that :
		- delete a node card in the hand to reinstance it on the board if its a creature
		- launch the spell if its a spell
	"""
	
	var card=get_node("All/Center/Self_Hand/"+node_name)
	
	# delete hand card
	if card.type == card.CREATURE:
		var card_uniq_id = player.ask_new_uniq_id(true)
		add_card_to_board(true, card.NAME, card_uniq_id)
		player.creature_played_from_hand(card.NAME, card.MANA_COST)
		
	elif card.type == card.SPELL:
		card.play_card(-1)
		player.spell_played_from_hand(card.NAME, card.MANA_COST)


func _on_opponent_creature_played(card_name):
	"""
	Called when the opponent plays a card
	Simply add the card to the board
	"""
	var card_uniq_id = player.ask_new_uniq_id(false)
	add_card_to_board(false, card_name, card_uniq_id) # "false" to put in the opponent side
	
	
func _on_opponent_creature_died(data):
	pass

func _on_Opponent_card_attacked(data):
	"""
	Called when you attack the opponent with a card
	Inform player.gd and change can_attack on the card, so it cant attack twice
	"""

	player.self_card_attack_opponent(data) # inform player



func _on_self_creature_fight(data): # called when 2 creatures will fight each others
	pass # nothing for now, maybe animations later
	
func _on_creature_hp_changed(data): 
	""" 
	Called when a hp modification on creature is needed
	Data[0] contain creature dico, and data[1] contains an int with the damage to do to the creature
	"""

	var creature
	if player.uniq_ids_list[data[0]["uniq_id"]]:
		#creature = get_node("All/Center/Board/Self_Board/"+data[0]["node_name"])
		creature = get_node("All/Center/Board/Self_Board/"+str(data[0]["uniq_id"]))
	else:
		creature = get_node("All/Center/Board/Opponent_Board/"+str(data[0]["uniq_id"]))
		#creature = get_node("All/Center/Board/Opponent_Board/"+data[0]["node_name"])
		
	if creature != null:
		creature.add_pv(data[1])
		
func _on_ask_side_popup(text):
	creature_focus_mode = true
	$Side_Popup.set_text_to_show(text)
	$Side_Popup.popup()

func _on_Side_Popup_popup_hide():
	creature_focus_mode = false
