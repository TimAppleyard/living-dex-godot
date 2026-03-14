class_name EncounterMenu

extends CanvasLayer

var pokeData: Dictionary
var encounter_listing_scene = preload("res://scenes/encounter_listing.tscn")
@onready var list_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer

func _ready() -> void:
	_fill_list()
	
func _fill_list() -> void:
	for item in pokeData["encounter_list"]:
		var new_encounter_listing: EncounterListing = encounter_listing_scene.instantiate()
		new_encounter_listing.set_data(item)
		list_container.add_child(new_encounter_listing)

func _on_exit_button_pressed() -> void:
	self.queue_free()

#give the menu the pokemon's data
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData
