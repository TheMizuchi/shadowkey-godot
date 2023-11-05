extends Node

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player_character")[0]
	#clear_current_level()

#TODO: this is horribly bad, don't mix stuff this way.
# figure out a more elegant system for doing this
func change_level(level_scene_string):
	var current_level = $"../world/level".get_child(0).name
	clear_current_level()
	var spawn_positions = load_level(level_scene_string)
	for spawn_position in spawn_positions.keys():
		if spawn_position == current_level:
			player.set_position(spawn_positions[spawn_position].position)
			player.set_rotation(spawn_positions[spawn_position].rotation)
	
func clear_current_level():
	$"../world/level".get_child(0).queue_free()
	#for current_level in $"../world/level".get_children():
		#current_level.queue_free()

func load_level(level):
	#TODO: lol stop this madness
	var spawn_points = {}
	var level_scene_path = "res://game/levels/"+str(level)+"/"+str(level)+".tscn"
	var level_instance = load(level_scene_path).instantiate()
	$"../world/level".add_child(level_instance)
	#for activator in level_instance.get_node("activators").get_children():
		#print(activator.name)
	for spawn_point in level_instance.get_node("player_spawn_positions").get_children():
		spawn_points[spawn_point.name] = spawn_point
		#TODO: also figure out how to preload next levels

	#TODO: are there any other dark levels?
	if level == "azra":
		player.get_node("light").show()
	else:
		player.get_node("light").hide()
	
	return spawn_points

#func select_next_weapon():
	#pass
