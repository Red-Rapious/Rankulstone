extends Button
tool

var on_board = false

export var NAME = "Nom de la carte"
export var MANA_COST = 1
export var IMAGE = ""
export var RARITY = 0
export var UNDER_TEXT = "\"Une carte vraiment qualitative\" - Un mec random"

""" -> on creature
signal enter_battlefield
signal quit_battlefield
"""

signal played

func _ready():
	$Name.text = NAME

func play_card():
	self.on_board = true
	self.emit_signal("played")
	
func create_drag_clone():
	var label = Label.new()
	label.text = "test"
	return label

func get_drag_data(_pos): # called when dragged
	if on_board:
		return "-1"
	
	set_drag_preview(create_drag_clone())
	
	# return mana cost to see if the card can be played
	return name