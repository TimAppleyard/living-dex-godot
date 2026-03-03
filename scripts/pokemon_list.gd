extends VBoxContainer

var poke_files_dir: String = "res://pokemon_files/"
var pokemonListingScene = preload("res://scenes/poke_listing.tscn")
var num_mons = 386

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_listings()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_listings() -> void:
	#Parse through every json file in pokemon_files, and create a PokeListing Node for it
	for id in range(1, num_mons+1):
		var file_location = poke_files_dir + str(id) + ".json"
		var poke_data = retrieve_json(file_location)
		#Create a new pokemon listing, give it it's data, and add it as a child
		var listing: PokeListing = pokemonListingScene.instantiate()
		listing.set_poke_data(poke_data)
		add_child(listing)
		listing.set_h_size_flags(SIZE_FILL)
	
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
