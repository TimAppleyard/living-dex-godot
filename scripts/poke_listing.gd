extends Button

var encounterMenuScene = preload("res://scenes/encounter_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	
func _button_pressed():
	var menu = encounterMenuScene.instantiate()
	add_child(menu)
