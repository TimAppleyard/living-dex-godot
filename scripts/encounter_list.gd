class_name EncounterList
extends VBoxContainer

var pokeData: Dictionary
var encounter_listing_scene = preload("res://scenes/encounter_listing.tscn")
@onready var game_filter: GameFilter = get_node("/root/GameFilters")
@onready var firered_title: RichTextLabel = $FireredTitle
@onready var firered_container: VBoxContainer = $FireRedContainer
@onready var leafgreen_title: RichTextLabel = $LeafgreenTitle
@onready var leafgreen_container: VBoxContainer = $LeafGreenContainer
@onready var ruby_title: RichTextLabel = $RubyTitle
@onready var ruby_container: VBoxContainer = $RubyContainer
@onready var sapphire_title: RichTextLabel = $SapphireTitle
@onready var sapphire_container: VBoxContainer = $SapphireContainer
@onready var emerald_title: RichTextLabel = $EmeraldTitle
@onready var emerald_container: VBoxContainer = $EmeraldContainer
	
#give the menu the pokemon's data
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData
	_fill_list()
	update_firered_visibility()
	update_leafgreen_visibility()
	update_ruby_visibility()
	update_sapphire_visibility()
	update_emerald_visibility()
	sort_by_area() #default to sorting by area
	
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
				
func sort_by_encounter_rate() -> void:
	for child in get_children():
		if child is VBoxContainer:
			var listings_array: Array = child.get_children()
			listings_array.sort_custom(func(a, b): return a.get_encounter_rate() > b.get_encounter_rate())
			for index in range(0, listings_array.size()):
				child.move_child(listings_array[index], index)
				
func sort_by_max_level() -> void:
	for child in get_children():
		if child is VBoxContainer:
			var listings_array: Array = child.get_children()
			listings_array.sort_custom(func(a, b): return a.get_max_level() > b.get_max_level())
			for index in range(0, listings_array.size()):
				child.move_child(listings_array[index], index)
				
func sort_by_area() -> void:
	for child in get_children():
		if child is VBoxContainer:
			var listings_array: Array = child.get_children()
			listings_array.sort_custom(func(a, b): \
				return a.get_route_info().naturalcasecmp_to(b.get_route_info()) < 0)
			for index in range(0, listings_array.size()):
				child.move_child(listings_array[index], index)
				
func update_firered_visibility() -> void:
	var game_visible = (firered_container.get_child_count() != 0)\
		and game_filter.firered_visibility
	firered_container.visible = game_visible
	firered_title.visible = game_visible
	
func update_leafgreen_visibility() -> void:
	var game_visible = (leafgreen_container.get_child_count() != 0)\
		and game_filter.leafgreen_visibility
	leafgreen_container.visible = game_visible
	leafgreen_title.visible = game_visible
	
func update_ruby_visibility() -> void:
	var game_visible = (ruby_container.get_child_count() != 0)\
		and game_filter.ruby_visibility
	ruby_container.visible = game_visible
	ruby_title.visible = game_visible
	
func update_sapphire_visibility() -> void:
	var game_visible = (sapphire_container.get_child_count() != 0)\
		and game_filter.sapphire_visibility
	sapphire_container.visible = game_visible
	sapphire_title.visible = game_visible
		
func update_emerald_visibility() -> void:
	var game_visible = (emerald_container.get_child_count() != 0)\
		and game_filter.emerald_visibility
	emerald_container.visible = game_visible
	emerald_title.visible = game_visible
		
