extends TextureButton
tool

enum {CREATURE, SPELL} # differents kinds of cards

export var type = 0
export var NAME = "Card"
export var MANA_COST = 1
export var IMAGE = ""
export var RARITY = 0
export var UNDER_TEXT = "\"Une carte vraiment qualitative\" - Un mec random"

signal played

func _ready():
	$VBoxContainer/Name.text = NAME
	$VBoxContainer/Action_Text.text = ""
	#$VBoxContainer/Under_text.text = UNDER_TEXT
	$VBoxContainer/Under_text.text = ""

func play_card():
	"""
	Called when this card is played
	Do some routine
	"""
	self.on_board = true
	self.emit_signal("played")
	
func create_play_drag_clone():
	"""
	Return the object created under the mouse when dragged
	"""
	var label = Label.new() # just create a simple label
	label.text = NAME
	return label
	
func create_drop_dico():
	return {"drag_type":0, "card_name": NAME, "node_name": name, "can_attack": false, "attack_value": 0, "is_self_side": false}

func get_drag_data(_pos): # called when dragged
	set_drag_preview(create_play_drag_clone()) # create and pass the drag preview created with specific function
	# return card name
	#return [0,NAME, name, false, 0, false] # return an array, see global enums (DRAG_TYPE, etc...)
	return create_drop_dico()
	
	
	
	
	