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
	Callable(self, "_on_pressed_item").bind(menus.WEAPONS)
	buttons[0].connect("pressed", Callable(self, "change_menu").bind(menus.WEAPONS))
	buttons[1].connect("pressed", Callable(self, "change_menu").bind(menus.ARMORS))
	buttons[2].connect("pressed", Callable(self, "change_menu").bind(menus.CONSUMABLES))
	buttons[3].connect("pressed", Callable(self, "change_menu").bind(menus.SPELLS))
	buttons[4].connect("pressed", Callable(self, "change_menu").bind(menus.MISCELLANEOUS))
	
	# Init List
	item_list = get_node("item_list")
	current_menu = menus.WEAPONS
	refresh_inventory();

# Function for inventory menu buttons
func change_menu(menu):
	current_menu = menu
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


