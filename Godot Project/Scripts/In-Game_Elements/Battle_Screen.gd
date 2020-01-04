extends Control

var creature_focus_mode = false
var waiting_spell = null
var creature_focus_timer

var spells_in_turn_wait = []

func _ready():
	connect_signals()
	
	if options.options_dico["toggle_fullscreen"]:
		OS.window_fullscreen = true
	
	player.init()
	_on_self_hand_changed() # update hand
	
func connect_signals():
	player.connect("opponent_creature_played", self, "_on_opponent_creature_played")
	player.connect("self_hand_changed", self, "_on_self_hand_changed")
	player.connect("self_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("opponent_creature_hp_changed", self, "_on_creature_hp_changed")
	player.connect("ask_side_popup", self, "_on_ask_side_popup")
	player.connect("ask_creature_kill", self, "_on_ask_creature_kill")
	
	player.connect("add_keyword", self, "_on_add_keyword")
	player.connect("add_one_turn_keyword", self, "_on_add_one_turn_keyword")
	player.connect("add_one_turn_attack", self, "_on_add_one_turn_attack")
	player.connect("add_one_turn_pv", self, "_on_add_one_turn_pv")
	
	player.connect("self_tour_begin", self, "_on_self_tour_begin")
	player.connect("opponent_turn_begin", self, "_on_opponent_turn_begin")
	
"""
func _process(delta):
	# quit game if escape is pressed
	if Input.is_action_pressed("ui_escape"):
		get_tree().quit()
"""

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
		apply_spell_effect(card)
		player.spell_played_from_hand(card.node_name , card.MANA_COST)
		
	elif card.type == card.FOCUS_SPELL:
		waiting_spell = card
		player.ask_side_popup("Sélectionne\nune créture")


func apply_spell_effect(spell, creature_id= -10):
	if spell.turns_before_effect == 0:
		if spell.type == spell.SPELL or spell.type == spell.FOCUS_SPELL:
			spell.play_card(-10) # no uniq id
		if [spell, creature_id] in spells_in_turn_wait:
			spells_in_turn_wait.erase([spell, creature_id])
			
		if spell.type == spell.FOCUS_SPELL or spell.type == spell.CREATURE:
			waiting_spell.apply_effect_to_creature(creature_id)
		
	else:
		spell.turns_before_effect -= 1
		spells_in_turn_wait.append([spell, creature_id])



func _on_opponent_creature_played(card_name):
	"""
	Called when the opponent plays a card
	Simply add the card to the board
	"""
	var card_uniq_id = player.ask_new_uniq_id(false, card_name)
	add_card_to_board(false, card_name, card_uniq_id) # "false" to put in the opponent side
	
	

func _on_Opponent_card_attacked(data):
	"""
	Called when you attack the opponent with a card
	Inform player.gd and change can_attack on the card, so it cant attack twice
	"""

	player.self_card_attack_opponent(data) # inform player
	
	
	
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
	#create_creature_focus_timer()
	yield(get_tree().create_timer(1.0), "timeout") # see creature focus timer
	if not $Side_Popup.visible:
		creature_focus_mode = false
		
		

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
		
		if waiting_spell.is_target_ok(creature_id): # if target is good
			apply_spell_effect(waiting_spell, creature_id)
		
		
			if waiting_spell.type == waiting_spell.CREATURE:
				var card_uniq_id = player.ask_new_uniq_id(true, waiting_spell.node_name)
				add_card_to_board(true, waiting_spell.node_name, card_uniq_id)
				player.creature_played_from_hand(waiting_spell.node_name, waiting_spell.MANA_COST)
				
			else:
				# if its a focus spell
				player.spell_played_from_hand(waiting_spell.node_name, waiting_spell.MANA_COST)
		
		else: # if target isn't good
			pass
			#player.ask_side_popup("Choisissez une créature") # relaunch
		
		
func _on_ask_creature_kill(creature_id):
	get_creature_by_id(creature_id).die()

func _on_Opponent_pressed():
	creature_pressed(-1) # -1 id = opponent

func _on_Self_pressed():
	creature_pressed(-2) # -2 id = self
	

# for the 4 following func, data is a list where data[0] is creature_id, and data[1] is keyword/value
func _on_add_keyword(data):
	get_creature_by_id(data[0]).add_keyword(data[1])
	
func _on_add_one_turn_keyword(data):
	get_creature_by_id(data[0]).add_one_turn_keyword(data[1])
	
func _on_add_one_turn_attack(data):
	get_creature_by_id(data[0]).add_one_turn_attack(data[1])
	
func _on_add_one_turn_pv(data):
	get_creature_by_id(data[0]).add_one_turn_pv(data[1])



func _on_self_tour_begin():
	reset_all_creatures_one_turn_values()
	play_waiting_turn_spells()
	
func _on_opponent_turn_begin():
	reset_all_creatures_one_turn_values()
	play_waiting_turn_spells()
	
func reset_all_creatures_one_turn_values():
	for creature in $All/Center/Board/Self_Board.get_children():
		creature.reset_one_turn_values()
		
	for creature in $All/Center/Board/Opponent_Board.get_children():
		creature.reset_one_turn_values()
	
func play_waiting_turn_spells():
	for spell in spells_in_turn_wait:
		apply_spell_effect(spell[0], spell[1])