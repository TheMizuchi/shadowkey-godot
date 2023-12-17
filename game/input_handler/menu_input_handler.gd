extends Node

var enabled = true
#var player_character
var current_menu
var inventory_menu

func _ready():
	#player_character = get_tree().get_first_node_in_group(&"player_character")
	inventory_menu = $"../../interface/menus/inventory_menu"
	set_process_input(true)

func _input(event):
	# Menu actions
	if event.is_action_pressed(&"inventory"):
		open_inventory()

func enable():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	enabled = true
	
func disable():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enabled = false

func open_inventory():
	if !inventory_menu.visible:
		inventory_menu.visible = true
		inventory_menu.refresh_inventory()
		enable()
	else:
		inventory_menu.visible = false
		disable()
	
