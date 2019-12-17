extends TextureButton

export var deck_name = "deck1"
var border = false

signal deck_pressed

func _ready():
	connect("pressed", self, "_on_Deck_pressed")
	update_label()

func _on_Deck_pressed():
	emit_signal("deck_pressed", deck_name)
	
func update_label():
	$Label.text = deck_name.capitalize()
	
func set_border(border_on):
	if border_on != border:
		border = border_on
		update_border()
		
		
func update_border():
	if border:
		$Label.text = "--- "+deck_name.capitalize()+" ---"
	else:
		$Label.text = deck_name.capitalize()