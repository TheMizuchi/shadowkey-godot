extends Node

var enabled = true
var inventory_menu

func _ready():
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
	for menu in $"../../interface/menus/".get_children():
		if menu != inventory_menu and menu.visible:
			return
	if not inventory_menu.visible:
		%logic.pause_game()
		inventory_menu.visible = true
		inventory_menu.refresh_inventory()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		inventory_menu.visible = false
		%logic.resume_game()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if(inventory_menu.removed_items.size() > 0):
			inventory_menu.spawn_removed_bag()
	
