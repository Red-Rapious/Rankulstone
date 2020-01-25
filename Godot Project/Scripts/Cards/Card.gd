extends TextureButton
tool

enum {NONE, CREATURE, SPELL, FOCUS_SPELL} # differents kinds of cards

var type = NONE
export var NAME = "Card"
export var node_name = "Card"
export var MANA_COST = 1
export var tribe = ["Neutre"]

var on_collection = false

var uniq_id = -1

signal played

func _ready():
	node_name = NAME
	update_labels()

func update_labels():
	""" --> void
	Simply update all the card labels
	"""
	
	update_name()
	$VBoxContainer/Top/Mana_cost.text = str(MANA_COST)
	
	update_tribe_label()
	
func update_name():
	$VBoxContainer/Top/Name.text = NAME

func update_tribe_label():
	var final_text = ""
	for i in tribe:
		final_text = final_text + i +", "
		
	
	final_text = final_text.substr(0, len(final_text)-2) # delete last coma
			
	$VBoxContainer/Tribe.text = final_text

func play_card(id):
	"""
	Called when this card is played
	Do some routine
	"""
	self.uniq_id = id
	self.emit_signal("played")
	
func create_play_drag_clone():
	"""
	Return the object created under the mouse when dragged
	"""
	var label = Label.new() # just create a simple label
	label.text = NAME
	return label
	
func create_drop_dico():
	"""
	Return a dictionnary with many informations
	Mainly used for drag&drop 
	"""
	return {"uniq_id": uniq_id, "drag_type":0, "card_name": node_name, "can_attack": false, "attack_value": 0, "is_self_side": false, "mana_cost":MANA_COST}

func get_drag_data(_pos): # called when dragged
	if not on_collection:
		set_drag_preview(create_play_drag_clone()) # create and pass the drag preview created with specific function
		return create_drop_dico()
		

func _on_Card_pressed():
	if on_collection:
		get_node("../../../../../").grid_card_pressed(node_name, NAME)
