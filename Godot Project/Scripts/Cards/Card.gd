extends TextureButton
tool

enum {CREATURE, SPELL}

#var on_board = false

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
	self.on_board = true
	self.emit_signal("played")
	
func create_play_drag_clone():
	var label = Label.new()
	label.text = NAME
	return label

func get_drag_data(_pos): # called when dragged
	#if on_board:
	#	return "-1"
	
	set_drag_preview(create_play_drag_clone())
	# return card name
	return [0,NAME, name, false, 0]