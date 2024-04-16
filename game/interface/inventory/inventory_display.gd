extends Node2D
@export var button_group: ButtonGroup

var parent_node
var item_list
var inventory
var equipment_types
var player_inventory = []
var removed_items = []

enum menus {WEAPONS, ARMORS, CONSUMABLES, SPELLS, MISCELLANEOUS}
var current_menu: menus = menus.WEAPONS
var selectTheme = preload("res://game/interface/inventory/selectButtonTheme.tres");
var normalTheme = preload("res://game/interface/inventory/normalButtonTheme.tres");

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
		if(current_menu == menus.CONSUMABLES):
			var item = get_tree().get_first_node_in_group(&"item_list").get_item(i)
			button.text = get_tree().get_first_node_in_group(&"item_list").get_item(i).name +' ' + str(player_inventory[current_menu][i])
			button.connect("pressed", Callable(self, "_on_pressed_item").bind(button, item))
		else:
			button.text = i.name
			button.connect("pressed", Callable(self, "_on_pressed_item").bind(button, i))
			if(inventory.is_equip(i)):
				button.theme = selectTheme
		button.set_button_mask(MOUSE_BUTTON_MASK_LEFT|MOUSE_BUTTON_MASK_RIGHT)
		item_list.add_child(button)

func _on_pressed_item(button, item):
	#TODO look for another mean to get right mouse button click
	if(Input.is_action_just_released("action2")):
		inventory.remove_item(item, 1)
		removed_items.append(item)
		refresh_inventory()
	else:
		select_item(button, item)
		
func spawn_removed_bag():
	var bag = preload("res://game/actors/objects/dropped_bag/bag.tscn").instantiate()
	bag.get_node("container").set_up_contents(removed_items)
	bag.position = %player.position-Vector3(0,%player.scale.y,0)
	get_tree().root.add_child(bag)
	removed_items.clear()

func select_item(button, item):
	if(current_menu == menus.WEAPONS && current_menu != menus.SPELLS):
		if(inventory.equipped_list.has(item)):
			button.theme = normalTheme
			inventory.unequip_item(item)
		else:
			button.theme = selectTheme
			inventory.equip_item(item)
	if(current_menu == menus.ARMORS):
		if(%player.has_armor_equipped(item)):
			inventory.unequip_item(item)
		else:
			inventory.equip_item(item)
		for i in range(item_list.get_child_count()):
			if(%player.has_armor_equipped(player_inventory[menus.ARMORS][i])):
				item_list.get_child(i).theme = selectTheme
			else:
				item_list.get_child(i).theme = normalTheme
