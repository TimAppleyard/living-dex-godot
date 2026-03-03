class_name EncounterMenu

extends CanvasLayer

var pokeData: Dictionary

func _on_button_pressed() -> void:
	self.queue_free()

#give the menu the pokemon's data
func set_poke_data(newData: Dictionary) -> void:
	pokeData = newData
