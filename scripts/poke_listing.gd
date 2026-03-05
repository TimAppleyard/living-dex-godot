class_name PokeListing

extends Button

var encounterMenuScene = preload("res://scenes/encounter_menu.tscn")
var pokeData: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	
func _button_pressed():
	var menu: EncounterMenu = encounterMenuScene.instantiate()
	menu.set_poke_data(pokeData)
	add_child(menu)

#give the listing the pokemon's data and changes the buttons ui and name
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData
	set_text(pokeData["name"])
