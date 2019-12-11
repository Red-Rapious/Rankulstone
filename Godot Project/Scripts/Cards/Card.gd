extends TextureButton
tool

enum {NONE, CREATURE, SPELL, FOCUS_SPELL} # differents kinds of cards

var type = NONE
export var NAME = "Card"
var node_name
export var MANA_COST = 1

#export var IMAGE = ""
#export var RARITY = 0
#export var UNDER_TEXT = "\"Une carte vraiment qualitative\" - Un mec random"
#export var text_color = Color(255,255,255)

var uniq_id = -1

signal played

func _ready():
	node_name = NAME
	update_labels()

func update_labels():
	""" --> void
	Simply update all the card labels
	"""
	$VBoxContainer/Top/Name.text = NAME
	$VBoxContainer/Top/Mana_cost.text = str(MANA_COST)
	$VBoxContainer/Action_Text.text = ""
	#$VBoxContainer/Under_text.text = UNDER_TEXT
	$VBoxContainer/Under_text.text = ""

func play_card(id):
#func play_card():
	"""
	Called when this card is played
	Do some routine
	"""
	self.uniq_id = id
	#self.on_board = true
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
	set_drag_preview(create_play_drag_clone()) # create and pass the drag preview created with specific function
	return create_drop_dico()
	
	
	
	
	