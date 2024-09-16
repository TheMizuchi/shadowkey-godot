extends Node



# TODO: lol stop abusing groups for the purpose of global variables
var player
var instant_start = true

# TODO: track removed entities, track exiisting entities with changed properties
var region_states = {}
enum levels {}
var dark_levels = [&"azra", &"broke1", &"broken2", &"delfhide", \
	&"erthcave", &"ffarena", &"lothcav", &"crypt1", &"crypt2", &"crypt3", \
	 &"fearfrst", &"lakvan", &"raiders", &"twilite"]

enum interact_type {container, character, shop, door, lockpick}

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_input_handler(&"fps")
	if instant_start:
		start_game()
		return
	show_main_menu()

func start_game():
	load_level(&"azra")
	set_input_handler(&"fps")
	$"../interface/hud".visible = true;

func pause_game():
	get_tree().paused = true
	$"../interface/hud".visible = false;

func resume_game():
	get_tree().paused = false
	$"../interface/hud".visible = true;

func set_input_handler(mode):
	%input_handler.set_current_handler(mode)

#TODO: this is horribly bad, don't mix stuff this way.
# figure out a more elegant system for doing this
func change_level(level_scene_string):
	var current_level = $"../world/level".get_child(0).name
	clear_current_level()
	var spawn_positions = load_level(level_scene_string)
	for spawn_position in spawn_positions.keys():
		if spawn_position == current_level:
			%player.set_position(spawn_positions[spawn_position].position)
			%player.set_rotation(spawn_positions[spawn_position].rotation)
			return
		# spawn player at the first listed spawn position in case
		# that there are no valid positions
		%player.set_position(spawn_positions.values()[0].position)
		%player.set_rotation(spawn_positions.values()[0].rotation)
	
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
	# yes, yes there are. Delfhide and probably other interiors as well
	if level in dark_levels:
		%player.get_node("light").show()
	else:
		%player.get_node("light").hide()
	return spawn_points

func menu_is_open():
	for menu in $"../interface/menus/".get_children():
		if menu.visible:
			return true
	return false

func open_menu(menu):
	pass

func show_main_menu():
	%input_handler.set_current_handler(&"menu")
	$"../interface/menus/main_menu".visible = true

func _on_player_death() -> void:
	%input_handler.set_current_handler(&"menu")
	$"../interface/menus/game_end_menu".visible = true

func preload_assets():
	pass

func exit_game():
	get_tree().quit()
