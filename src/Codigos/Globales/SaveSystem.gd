extends Node

func save_game(saveLevels):
	pass
#	var save_game = File.new()
#	save_game.open("user://savegame.save", File.WRITE)
#	var save_nodes = get_tree().get_nodes_in_group("Persist")
#	var save_dict = {levels = saveLevels}	
#	save_game.store_line(to_json(save_dict))
#	save_game.close()

func load_game():
	pass
#	var save_game = File.new()
#	if not save_game.file_exists("user://savegame.save"):
#		return # Error! We don't have a save to load.
#
#	save_game.open("user://savegame.save", File.READ)
#	while save_game.get_position() < save_game.get_len():
#		# Get the saved dictionary from the next line in the save file
#		var node_data = parse_json(save_game.get_line())
#		if(node_data.levels):
#			Manager.nivelesDesbloqueados = node_data.levels
#	save_game.close()
