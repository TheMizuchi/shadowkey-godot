extends Control

const equipment_list = preload("res://game/game_logic/equipment_list.gd")

@export var button_group: ButtonGroup


var parent_node
var item_list
var inventory

enum menus {WEAPONS, ARMORS, CONSUMABLES, SPELLS, MISCELLANEOUS}
var current_menu: menus = menus.WEAPONS

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	inventory = %player.find_child("inventory")
	# Init Button group
	var buttons = button_group.get_buttons()
	buttons[0].connect("pressed", change_menu_weapons)
	buttons[1].connect("pressed", change_menu_armors)
	buttons[2].connect("pressed", change_menu_consumables)
	buttons[3].connect("pressed", change_menu_enchants)
	buttons[4].connect("pressed", change_menu_miscellaneous)
	
	# Init List
	item_list = get_node("item_list")
	current_menu = menus.WEAPONS
	refresh_inventory();

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
	current_menu = menus.SPELLS
	refresh_inventory()
	
func change_menu_miscellaneous():
	current_menu = menus.MISCELLANEOUS
	refresh_inventory()

func refresh_inventory():
	for item in item_list.get_children():
		item_list.remove_child(item)
	var list = []
	match (current_menu):
		menus.WEAPONS:
			list = inventory.weapons
		menus.ARMORS:
			list = inventory.armors
		menus.CONSUMABLES:
			list = inventory.consumables
		menus.SPELLS:
			list = inventory.spells
		menus.MISCELLANEOUS:
			list = inventory.misc
	for i in list:
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.text = i[0]
		item_list.add_child(label)


