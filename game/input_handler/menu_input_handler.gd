extends Node

var enabled = true
var inventory_menu
var character_menu

func _ready():
	inventory_menu = $"../../interface/menus/inventory_menu"
	character_menu = $"../../interface/menus/character_attributes"
	set_process_input(true)

func _input(event):
	# Menu actions
	# TODO: this should probably be in FPS handler
	if event.is_action_pressed(&"inventory"):
		open_inventory()
	if event.is_action_pressed(&"characterMenu"):
		open_character_menu()

func enable():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	enabled = true

# TODO: this never gets called lol
func disable():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enabled = false

func open_inventory():
	for menu in $"../../interface/menus/".get_children():
		if menu != inventory_menu and menu.visible:
			return
	if not inventory_menu.visible:
		%logic.pause_game()
		inventory_menu.visible = true
		inventory_menu.refresh_inventory()
		%logic.set_input_handler(&"menu")
	else:
		inventory_menu.visible = false
		%logic.resume_game()
		%logic.set_input_handler(&"fps")
		if(inventory_menu.removed_items.size() > 0):
			inventory_menu.spawn_removed_bag()
	

func open_character_menu():
	for menu in $"../../interface/menus/".get_children():
		if menu != character_menu and menu.visible:
			return
	if not character_menu.visible:
		%logic.pause_game()
		character_menu.visible = true
		%logic.set_input_handler(&"menu")
	else:
		character_menu.visible = false
		%logic.resume_game()
		%logic.set_input_handler(&"fps")
	
