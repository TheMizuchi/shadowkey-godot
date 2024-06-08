extends Node

var item_list

signal amount_changed
signal item_added
signal item_removed
signal equip(item)
signal unequip(item)

#var ammo = 100

var weapons = []
var armors = []
var consumables = {}
var spells = []
var misc = []

var gold = 0
var equipped_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	item_list = get_tree().get_first_node_in_group(&"item_list")

func add_item(newItem, quantity):
	var item = newItem.duplicate()
	if(item.id == &"goldpiece"):
		gold += quantity
	elif(item_list.weapons.has(item.id)):
		if(weapons.is_empty() && spells.is_empty()):
			equip.emit(item)
		weapons.append(item)
	elif(item_list.armors.has(item.id)):
		armors.append(item)
	elif(item_list.consumables.has(item.id)):
		if(consumables.has(item.id)):
			consumables[item.id] += 1
		else:
			consumables[item.id] = 1
	elif(item_list.spells.has(item.id)):
		if(weapons.is_empty() && spells.is_empty()):
			equip.emit(item)
		spells.append(item)
	elif(item_list.misc.has(item.id)):
		misc.append(item)
	else:
		return
	item_added.emit()

func add_items(items):
	for item in items:
		add_item(item, 1)

func remove_item(item, quantity):
	if(item.id == &"goldpiece"):
		gold += quantity
	elif(weapons.has(item)):
		weapons.remove_at(weapons.find(item))
		unequip.emit(item)
	elif(armors.has(item)):
		armors.remove_at(armors.find(item))
	elif(consumables.has(item.id)):
		consumables[item.id] -=1
		if(consumables[item.id] == 0):
			consumables.erase(item.id)
	elif(spells.has(item)):
		spells.remove_at(spells.find(item))
		unequip.emit(item)
	elif(misc.has(item)):
		misc.remove_at(misc.find(item))
	else:
		return

func equip_item(item):
	equip.emit(item)

func unequip_item(item):
	unequip.emit(item)

func is_equip(item):
	return equipped_list.has(item)

#func set_item_count(item, value):
	#pass
#
#func increase_item_count(item, value):
	#pass
#
#func reduce_item_count(item, value):
	#pass
