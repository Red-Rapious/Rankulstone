extends Control

func _ready():
	decks.save_deck("deck1")
	$ProgressBar.set_value(5)

