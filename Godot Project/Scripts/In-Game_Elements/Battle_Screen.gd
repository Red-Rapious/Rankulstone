extends Control

var creature_focus_mode = false
var waiting_spell = null
var creature_focus_timer

func _ready():
	player.connect("opponent_creature_played", self, "_on_opponent_creature_played")
	player.connect("opponent_creature_died", self, "_on_opponent_creature_died")
	player.connect("self_hand_changed", self, "_on_self_hand_changed")
	player.connect("self_creature_fight", self, "_on_self_creature_fight")
	player.connect("self_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("opponent_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("ask_side_popup", self, "_on_ask_side_popup")
	player.connect("ask_creature_kill", self, "_on_ask_creature_kill")
	player.connect("opponent_ask_creature_kill", self, "_on_opponent_ask_creature_kill")
	
	if options.options_dico["toggle_fullscreen"]:
		OS.window_fullscreen = true
	
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
		$All/Center/Self_Hand_ScrollContainer/Self_Hand.add_child(scene_instance)
		
func clean_hand():
	"""
	This function delete all nodes from the player's hand
	"""
	for node in $All/Center/Self_Hand_ScrollContainer/Self_Hand.get_children():
		$All/Center/Self_Hand_ScrollContainer/Self_Hand.remove_child(node)

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

	# add instance to the board
	if self_side:
		$All/Center/Board/Self_Board.add_child(scene_instance)
	else:
		$All/Center/Board/Opponent_Board.add_child(scene_instance)
		
	scene_instance.play_card(card_uniq_id)
	scene_instance.is_self_side = self_side
	

func play_card_from_hand(node_name: String):
	"""
	A function that :
		- delete a node card in the hand to reinstance it on the board if its a creature
		- launch the spell if its a spell
	"""
	
	var card=get_node("All/Center/Self_Hand_ScrollContainer/Self_Hand/"+node_name)
	
	if card.type == card.CREATURE:
		if not card.has_enter_battlefield_focus:
			var card_uniq_id = player.ask_new_uniq_id(true, node_name)
			add_card_to_board(true, card.node_name, card_uniq_id)
			player.creature_played_from_hand(card.node_name, card.MANA_COST)
		else:
			waiting_spell = card
			player.ask_side_popup("Sélectionne\nune créture")
		
	elif card.type == card.SPELL:
		card.play_card(-1)
		player.spell_played_from_hand(card.node_name , card.MANA_COST)
		
	elif card.type == card.FOCUS_SPELL:
		waiting_spell = card
		player.ask_side_popup("Sélectionne\nune créture")


func _on_opponent_creature_played(card_name):
	"""
	Called when the opponent plays a card
	Simply add the card to the board
	"""
	var card_uniq_id = player.ask_new_uniq_id(false, card_name)
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
	Data[0] contain creature id, and data[1] contains an int with the damage to do to the creature
	"""

	var creature
	if player.uniq_ids_list[data[0]][player.SELF_SIDE]:
		creature = get_node("All/Center/Board/Self_Board/"+str(data[0]))
	else:
		creature = get_node("All/Center/Board/Opponent_Board/"+str(data[0]))
		
	if creature != null:
		creature.add_pv(data[1])
		
		
		
		
func _on_ask_side_popup(text):
	creature_focus_mode = true
	$Side_Popup.set_text_to_show(text)
	$Side_Popup.popup()

func _on_Side_Popup_popup_hide():
	create_creature_focus_timer()



func create_creature_focus_timer():
	"""
	To resolve a silly bug, the creature focus mode (bool) is going to be set to false
	only 0.5 seconds ater the popup is hiding.
	This timer is here for that.
	"""
	creature_focus_timer = Timer.new()
	creature_focus_timer.name = "Timer"
	creature_focus_timer.connect("timeout",self,"_on_creature_focus_timer_timeout") 
	creature_focus_timer.set_wait_time(0.5)
	add_child(creature_focus_timer) #to process
	creature_focus_timer.start() #to start

func _on_creature_focus_timer_timeout():
	"""
	Called when the timer timeout. Only set the bool to false, and delete the node to avoid conflicts
	"""
	creature_focus_mode = false
	get_node("Timer").queue_free()


func get_creature_by_id(creature_id):
	if player.uniq_ids_list[creature_id][player.SELF_SIDE]:
		return get_node("All/Center/Board/Self_Board/"+str(creature_id))
	else:
		return get_node("All/Center/Board/Opponent_Board/"+str(creature_id))



func creature_pressed(creature_id):
	"""
	Called by a creature when it's pressed
	"""
	if creature_focus_mode:
		apply_effect_to_creature(creature_id)
		
		
func apply_effect_to_creature(creature_id):
	if waiting_spell != null:
		waiting_spell.apply_effect_to_creature(creature_id)
		if waiting_spell.type == waiting_spell.CREATURE:
			var card_uniq_id = player.ask_new_uniq_id(true, waiting_spell.node_name)
			add_card_to_board(true, waiting_spell.node_name, card_uniq_id)
			player.creature_played_from_hand(waiting_spell.node_name, waiting_spell.MANA_COST)
		else:
			player.card_played_from_hand(waiting_spell.node_name, waiting_spell.MANA_COST)
		
		
func _on_ask_creature_kill(creature_id):
	get_creature_by_id(creature_id).die()
	
func _on_opponent_ask_creature_kill(creature_id):
	get_creature_by_id(creature_id).die()