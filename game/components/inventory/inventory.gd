extends Node

var equipment_list = preload("res://game/game_logic/equipment_list.gd")

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
	pass # Replace with function body.

func add_item(item):
	if(equipment_list.weapons.has(item)):
		if(weapons.is_empty()):
			first_attack.emit(equipment_list.weapons[item])
		weapons.append(equipment_list.weapons[item])
	elif(equipment_list.armors.has(item)):
		armors.append(equipment_list.armors[item])
	elif(equipment_list.consumables.has(item)):
		consumables.append(equipment_list.consumables[item])
	elif(equipment_list.spells.has(item)):
		if(spells.is_empty()):
			first_attack.emit(equipment_list.spells[item])
		spells.append(equipment_list.spells[item])
	elif(equipment_list.misc.has(item)):
		misc.append(equipment_list.misc[item])
	else:
		return
	item_added.emit()

func add_items(items):
	for item in items:
		add_item(item)

#func remove_item(cat, id, quantity):
	#pass
#
#func set_item_count(item, value):
	#pass
#
#func increase_item_count(item, value):
	#pass
#
#func reduce_item_count(item, value):
	#pass
