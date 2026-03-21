class_name EncounterMenu

extends CanvasLayer

var pokeData: Dictionary
var encounter_listing_scene = preload("res://scenes/encounter_listing.tscn")
@onready var game_filter: GameFilter = get_node("/root/GameFilters")
@onready var list_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer
@onready var emerald_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer/EmeraldContainer
@onready var sapphire_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer/SapphireContainer
@onready var ruby_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer/RubyContainer
@onready var firered_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer/FireRedContainer
@onready var leafgreen_container: VBoxContainer = $MarginContainer/ColorRect/ScrollContainer/ListContainer/LeafGreenContainer
@onready var firered_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/FireredSelector
@onready var leafgreen_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/LeafgreenSelector
@onready var ruby_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/RubySelector
@onready var sapphire_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/SapphireSelector
@onready var emerald_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/EmeraldSelector


func _ready() -> void:
	_set_selector_toggles()
	_fill_list()
	_apply_game_filter()

func _fill_list() -> void:
	for item in pokeData["encounter_list"]:
		var new_encounter_listing: EncounterListing = encounter_listing_scene.instantiate()
		new_encounter_listing.set_data(item)
		#add each listing into the correct vbox depending on version
		match new_encounter_listing.get_game():
			"emerald":
				emerald_container.add_child(new_encounter_listing)
			"sapphire":
				sapphire_container.add_child(new_encounter_listing)
			"ruby":
				ruby_container.add_child(new_encounter_listing)
			"firered":
				firered_container.add_child(new_encounter_listing)
			"leafgreen":
				leafgreen_container.add_child(new_encounter_listing)
		
		
#will set the visibility of each encounter listing based on the global game filter
func _apply_game_filter() -> void:
	var game_filter: GameFilter = get_node("/root/GameFilters")
	emerald_container.visible = game_filter.emerald_visibility
	sapphire_container.visible = game_filter.sapphire_visibility
	ruby_container.visible = game_filter.ruby_visibility
	firered_container.visible = game_filter.firered_visibility
	leafgreen_container.visible = game_filter.leafgreen_visibility

func _on_exit_button_pressed() -> void:
	self.queue_free()

#give the menu the pokemon's data
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData

func _set_selector_toggles() -> void:
	firered_selector.button_pressed = !game_filter.firered_visibility
	leafgreen_selector.button_pressed = !game_filter.leafgreen_visibility
	ruby_selector.button_pressed = !game_filter.ruby_visibility
	sapphire_selector.button_pressed = !game_filter.sapphire_visibility
	emerald_selector.button_pressed = !game_filter.emerald_visibility

func _on_firered_selector_toggled(toggled_on: bool) -> void:
	game_filter.firered_visibility = !toggled_on
	_apply_game_filter()

func _on_leafgreen_selector_toggled(toggled_on: bool) -> void:
	game_filter.leafgreen_visibility = !toggled_on
	_apply_game_filter()

func _on_ruby_selector_toggled(toggled_on: bool) -> void:
	game_filter.ruby_visibility = !toggled_on
	_apply_game_filter()

func _on_sapphire_selector_toggled(toggled_on: bool) -> void:
	game_filter.sapphire_visibility = !toggled_on
	_apply_game_filter()

func _on_emerald_selector_toggled(toggled_on: bool) -> void:
	game_filter.emerald_visibility = !toggled_on
	_apply_game_filter()
