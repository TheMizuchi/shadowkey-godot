class_name Inventory
extends Resource

var item_list: ItemsList = null

signal amount_changed
signal item_added
signal item_removed
signal equip(item)
signal unequip(item)

#var ammo = 100

var weapons: Array[ItemsList.Weapon] = []
var armors: Array[ItemsList.Armor] = []
var consumables: Dictionary = {}
var spells: Array[ItemsList.Spell] = []
var misc: Array[ItemsList.Misc] = []

var gold = 0
var equipped_list = []

func add_item(item): #, quantity):
	if item.get_class_name() == &"Gold":
		gold += item.amount
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
		add_item(item)#, 1)

func remove_item(item, quantity):
	if item.get_class_name() == &"Gold":
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

func inventory_to_dict() -> Dictionary:
	var weapons_str: Array[String] = []
	for weapon in weapons:
		weapons_str.append(weapon.id)

	var armors_str: Array[String] = []
	for armor in armors:
		armors_str.append(armor.id)

	var spells_str: Array[String] = []
	for spell in spells:
		spells_str.append(spell.id)

	var misc_str: Array[String] = []
	for miscItem in misc:
		misc_str.append(miscItem.id)

	var equipped_str: Array[String] = []
	for equipped in equipped_list:
		equipped_str.append(equipped.id)

	return {
		"weapons":weapons_str,
		"armors":armors_str,
		"spells":spells_str,
		"consumables":consumables,
		"misc":misc_str,
		"gold": gold,
		"equipped_list":equipped_str,
	}

func dict_to_inventory(dict: Dictionary):
	weapons = []
	armors = []
	consumables = {}
	spells = []
	misc = []
	equipped_list = []

	var weapons_str: Array[String] = dict["weapons"]
	for weapon in weapons_str:
		add_item(item_list.get_item(weapon))

	var armors_str: Array[String] = dict["armors"]
	for armor in armors_str:
		add_item(item_list.get_item(armor))

	var spells_str: Array[String] = dict["spells"]
	for spell in spells_str:
		add_item(item_list.get_item(spell))

	var misc_str: Array[String] = dict["misc"]
	for miscItem in misc_str:
		add_item(item_list.get_item(miscItem))

	var equipped_str: Array[String] = dict["equipped_list"]
	for equipped in equipped_str:
		if equipped in weapons_str:
			for weapon in weapons:
				if weapon not in equipped_list && weapon.id == equipped:
					equipped_list.append(weapon)
		else:
			for spell in spells:
				if spell not in equipped_list && spell.id == equipped:
					equipped_list.append(spell)

	consumables = dict["consumables"]
	gold = dict["gold"]

#func set_item_count(item, value):
	#pass
#
#pass#func increase_item_count(item, value):
	#pass
#
#func reduce_item_count(item, value):
