extends TextureButton

export var icon_number = 0

func _ready():
	texture_normal = load("res://Assets/Icons/"+str(icon_number)+".jpg")