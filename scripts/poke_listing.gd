class_name PokeListing

extends Button

var encounterMenuScene = preload("res://scenes/encounter_menu.tscn")
@onready var check_button: CheckBox = $CheckButton

var pokeData: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)

#Allows for the loading of the save file to automatically check the checkbox
#for pokemon obtained
func set_obtained_status(new_status: bool) -> void:
	check_button.button_pressed = new_status

#Allows the toggleing of the checkbox to be connected to a parent nodes save function	
func set_save_signal(save_function: Callable) -> void:
	check_button.pressed.connect(save_function)

func get_obtained_status() -> bool:
	return check_button.button_pressed
	
func get_poke_name() -> String:
	return pokeData["name"]

#When the pokemon listing is pressed, open the encounter menu
func _button_pressed():
	var menu: EncounterMenu = encounterMenuScene.instantiate()
	menu.set_poke_data(pokeData)
	add_child(menu)

#give the listing the pokemon's data and changes the buttons ui and name
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData
	set_text(pokeData["name"])
