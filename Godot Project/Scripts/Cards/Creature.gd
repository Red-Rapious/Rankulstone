extends "res://Scripts/Cards/Card.gd"

export var max_hp = 5
export var attack = 5
var hp = max_hp
export var keywords = ["Taunt"]

signal start_fight
signal get_damaged
signal attack
signal hp_is_zero