extends Node2D
@export var button_group: ButtonGroup

var parent_node
var item_list
var inventory
var player_inventory = []
var remove_items = []

enum menus {WEAPONS, ARMORS, CONSUMABLES, SPELLS, MISCELLANEOUS}
var current_menu: menus = menus.WEAPONS

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	inventory = %player.find_child("inventory")
	# Init Button group
	var buttons = button_group.get_buttons()
	Callable(self, "_on_pressed_item").bind(menus.WEAPONS)
	buttons[0].connect("pressed", Callable(self, "change_menu").bind(menus.WEAPONS))
	buttons[1].connect("pressed", Callable(self, "change_menu").bind(menus.ARMORS))
	buttons[2].connect("pressed", Callable(self, "change_menu").bind(menus.CONSUMABLES))
	buttons[3].connect("pressed", Callable(self, "change_menu").bind(menus.SPELLS))
	buttons[4].connect("pressed", Callable(self, "change_menu").bind(menus.MISCELLANEOUS))
	
	# Init List
	item_list = get_node("inventory_display/item_list")
	current_menu = menus.WEAPONS
	player_inventory = [inventory.weapons, 
						inventory.armors, 
						inventory.consumables, 
						inventory.spells, 
						inventory.misc]

# Function for inventory menu buttons
func change_menu(menu):
	current_menu = menu
	refresh_inventory()

func refresh_inventory():
	for item in item_list.get_children():
		item_list.remove_child(item)
	var list = player_inventory[current_menu]
	for i in list:
		var button = Button.new()
		button.text = i.name
		button.connect("pressed", Callable(self, "_on_pressed_item").bind(button, i))
		button.set_button_mask(MOUSE_BUTTON_MASK_LEFT|MOUSE_BUTTON_MASK_RIGHT)
		item_list.add_child(button)

func _on_pressed_item(button, item):
	#TODO look for another mean to get right mouse button click
	if(Input.is_action_just_released("action2")):
		print("remove")
	else:
		print("equip")
