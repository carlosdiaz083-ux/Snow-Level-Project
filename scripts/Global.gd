extends Node

var active_spawn # Holds the current active checkpoint node
var save_files_slots = [] # Holds all save file slots
var active_save_file_index # Index of selected save file

func _init():
	pass

func get_value(section: String, key: String):
	if save_files_slots.size() > 0 and active_save_file_index != null:
		var file = save_files_slots[active_save_file_index]
		if file and file.has_section_key(section, key):
			return file.get_value(section, key)
	return null
