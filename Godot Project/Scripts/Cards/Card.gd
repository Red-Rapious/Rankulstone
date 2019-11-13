extends Control
tool

export var NAME = "Nom de la carte"
export var MANA_COST = 1
export var IMAGE = ""
export var RARITY = 0
export var UNDER_TEXT = "\"Une carte vraiment qualitative\" - Un mec random"

signal enter_battlefield
signal quit_battlefield

func _ready():
	$Name.text = NAME
