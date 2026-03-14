extends VBoxContainer

var poke_files_dir: String = "res://pokemon_files/"
var pokemonListingScene = preload("res://scenes/poke_listing.tscn")
var num_mons = 386
var save_file_location: String = "res://livingdex.save"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_listings()
	load_save_file()

func save() -> void:
	var save_file = FileAccess.open(save_file_location, FileAccess.WRITE)
	for child: Node in get_children():
		if child is PokeListing:
			var node_data = {"Obtained": child.get_obtained_status()}
			var json_string = JSON.stringify(node_data)
			save_file.store_line(json_string)
		else:
			push_error("Child node of PokemonList is not of type PokeListing")
			
func load_save_file() -> void:
	#First time loading, may be no file to load
	if not FileAccess.file_exists(save_file_location):
		return
		
	var save_file = FileAccess.open(save_file_location, FileAccess.READ)
	var listings: Array = get_children()
	var listing_location = 0
	while (save_file.get_position() < save_file.get_length()) and (listing_location < listings.size()):
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.data
		listings[listing_location].set_obtained_status(node_data["Obtained"])
		listing_location += 1
		
	
func create_listings() -> void:
	#Parse through every json file in pokemon_files, and create a PokeListing Node for it
	for id in range(1, num_mons+1):
		var file_location = poke_files_dir + str(id) + ".json"
		var poke_data = retrieve_json(file_location)
		#Create a new pokemon listing, give it it's data, and add it as a child
		var listing: PokeListing = pokemonListingScene.instantiate()
		listing.set_poke_data(poke_data)
		add_child(listing)
		listing.set_save_signal(save)
	
func retrieve_json(file_location: String) -> Dictionary:
	#Get the string out of the given file
	var file_text = FileAccess.get_file_as_string(file_location)
	
	#Read in the json data
	var json = JSON.new()
	var error = json.parse(file_text)
	if error == OK:
		var data_recieved = json.data
		if typeof(data_recieved) == TYPE_DICTIONARY:
			return data_recieved
		else: 
			print("Unexpected data")
			return {}
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file_text, " at line ", json.get_error_line())
		return {}

func _on_line_edit_text_changed(new_text: String) -> void:
	for child: Node in get_children():
		if(child is PokeListing):
			if(new_text.is_empty() or child.get_poke_name().containsn(new_text)):
				child.visible = true
			else:
				child.visible = false
		else:
			push_error("Child node of PokemonList is not of type PokeListing")
