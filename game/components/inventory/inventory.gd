extends Node

var equipment_list

signal amount_changed
signal item_added
signal item_removed
signal first_attack(item)

#var ammo = 100

var weapons = []
var armors = []
var consumables = []
var spells = []
var misc = []

var gold = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_list = get_tree().get_first_node_in_group(&"item_list")

func add_item(item):
	if(equipment_list.weapons.has(item.id)):
		if(weapons.is_empty()):
			first_attack.emit(item)
		weapons.append(item)
	elif(equipment_list.armors.has(item.id)):
		armors.append(item)
	elif(equipment_list.consumables.has(item.id)):
		consumables.append(item)
	elif(equipment_list.spells.has(item.id)):
		if(spells.is_empty()):
			first_attack.emit(item)
		spells.append(item)
	elif(equipment_list.misc.has(item.id)):
		misc.append(item)
	else:
		return
	item_added.emit()

func add_items(items):
	for item in items:
		add_item(item)

func remove_item(cat, id, quantity):
	pass
#
#func set_item_count(item, value):
	#pass
#
#func increase_item_count(item, value):
	#pass
#
#func reduce_item_count(item, value):
	#pass
