class_name EncounterMenu

extends CanvasLayer

var pokeData: Dictionary
var encounter_listing_scene = preload("res://scenes/encounter_listing.tscn")
@onready var game_filter: GameFilter = get_node("/root/GameFilters")

@onready var firered_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/FireredSelector
@onready var leafgreen_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/LeafgreenSelector
@onready var ruby_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/RubySelector
@onready var sapphire_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/SapphireSelector
@onready var emerald_selector: Button = $MarginContainer/ColorRect/GameSelectorContainer/EmeraldSelector

@onready var encounter_list: EncounterList = $MarginContainer/ColorRect/ScrollContainer/EncounterList

func _ready() -> void:
	encounter_list.set_poke_data(pokeData)
	_set_selector_toggles()

func _on_exit_button_pressed() -> void:
	self.queue_free()

#give the menu the pokemon's data, must happen before encounter menu joins the tree
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData

#sets the selector buttons to be toggled based on game filter
func _set_selector_toggles() -> void:
	firered_selector.button_pressed = !game_filter.firered_visibility
	leafgreen_selector.button_pressed = !game_filter.leafgreen_visibility
	ruby_selector.button_pressed = !game_filter.ruby_visibility
	sapphire_selector.button_pressed = !game_filter.sapphire_visibility
	emerald_selector.button_pressed = !game_filter.emerald_visibility

func _on_firered_selector_toggled(toggled_on: bool) -> void:
	game_filter.firered_visibility = !toggled_on
	encounter_list.update_firered_visibility()

func _on_leafgreen_selector_toggled(toggled_on: bool) -> void:
	game_filter.leafgreen_visibility = !toggled_on
	encounter_list.update_leafgreen_visibility()

func _on_ruby_selector_toggled(toggled_on: bool) -> void:
	game_filter.ruby_visibility = !toggled_on
	encounter_list.update_ruby_visibility()

func _on_sapphire_selector_toggled(toggled_on: bool) -> void:
	game_filter.sapphire_visibility = !toggled_on
	encounter_list.update_sapphire_visibility()

func _on_emerald_selector_toggled(toggled_on: bool) -> void:
	game_filter.emerald_visibility = !toggled_on
	encounter_list.update_emerald_visibility()


func _on_sort_button_item_selected(index: int) -> void:
	match index:
		0:
			encounter_list.sort_by_area()
		1:
			encounter_list.sort_by_max_level()
		2:
			encounter_list.sort_by_encounter_rate()
