extends "res://Scripts/Cards/Card.gd"

signal played

func play_card():
	self.emit_signal("played")

func set_ghost(value):
	pass
	
func create_drag_clone():
	pass

func get_drag_data(_pos): # called when dragged
	var label = Label.new()
	label.text = "test"
	#set_drag_preview(create_drag_clone())
	set_drag_preview(label)
	
	# return mana cost to see if the card can be played
	return name