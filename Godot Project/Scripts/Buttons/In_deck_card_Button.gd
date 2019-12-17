extends Button

var card_name
var number

func init(new_card_name, new_number):
	card_name = new_card_name
	number = new_number
	update_text()

func update_text():
	text = str(number)+ "x "+ card_name

func _on_In_deck_card_Button_pressed():
	get_node("../../../../../").in_deck_card_button_pressed(card_name)
