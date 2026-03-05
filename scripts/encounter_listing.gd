extends ColorRect

@onready var route_info_label: Label = $HSplitContainer/VBoxContainer/RouteInfoLabel
@onready var encounter_method_label: Label = $HSplitContainer/VBoxContainer/EncounterMethodLabel
@onready var level_range_label: Label = $HSplitContainer/VBoxContainer/LevelRangeLabel
@onready var encounter_rate_label: Label = $HSplitContainer/EncounterRateLabel

var encounter_data: Dictionary

func _ready() -> void:
	_change_labels()
	
func _change_labels() -> void:
	route_info_label.text = encounter_data["location"]
	encounter_method_label.text = encounter_data["method"]
	level_range_label.text = "Lv. " + str(encounter_data["min_level"]) + " - Lv. " + str(encounter_data["max_level"])
	encounter_rate_label.text = str(encounter_data["rarity"])

func set_data(new_data: Dictionary) -> void:
	encounter_data = new_data
