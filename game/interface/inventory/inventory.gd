extends Control

const equipment_list = preload("res://game/game_logic/equipment_list.gd")

@export var button_group: ButtonGroup

var parent_node
var item_list

enum menus {WEAPONS, ARMORS, CONSUMABLES, ENCHANTS, MISCELLANEOUS}
var current_menu: menus

var weapons = [[ "Iron Dagger", equipment_list.types.Shortblade , 4, 5, 38, 13], [ "Iron Dagger", equipment_list.types.Shortblade , 4, 5, 38, 13]]
var armors = []
var consumables = []
var enchants = []
var miscellaneous = []

# Functions for inventory menu buttons
func change_menu_weapons():
	current_menu = menus.WEAPONS
	refresh_inventory()
	
func change_menu_armors():
	current_menu = menus.ARMORS
	refresh_inventory()
	
func change_menu_consumables():
	current_menu = menus.CONSUMABLES
	refresh_inventory()
	
func change_menu_enchants():
	current_menu = menus.ENCHANTS
	refresh_inventory()
	
func change_menu_miscellaneous():
	current_menu = menus.MISCELLANEOUS
	refresh_inventory()

func refresh_inventory():
	item_list.clear()
	var list
	match (current_menu):
		menus.WEAPONS:
			list = weapons
		menus.ARMORS:
			list = armors
		menus.CONSUMABLES:
			list = consumables
		menus.ENCHANTS:
			list = enchants
		menus.MISCELLANEOUS:
			list = miscellaneous
	for i in list:
		item_list.add_item(i[0])

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	
	# Init Button group
	var buttons = button_group.get_buttons()
	buttons[0].connect("pressed", change_menu_weapons)
	buttons[1].connect("pressed", change_menu_armors)
	buttons[2].connect("pressed", change_menu_consumables)
	buttons[3].connect("pressed", change_menu_enchants)
	buttons[4].connect("pressed", change_menu_miscellaneous)
	
	# Init List
	item_list = get_node("ItemList")
	current_menu = menus.WEAPONS
	refresh_inventory();

func add_item():
	pass


