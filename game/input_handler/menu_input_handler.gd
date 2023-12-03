extends Node

var player_character
var inventory_menu

func _ready():
	player_character = get_tree().get_first_node_in_group("player_character")
	inventory_menu = $"../../interface/menus/inventory_display"

func _input(event):
	# Menu actions
	if event.is_action_pressed("inventory"):
		open_inventory()

func open_inventory():
	if !inventory_menu.visible:
		inventory_menu.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		inventory_menu.visible = false
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
