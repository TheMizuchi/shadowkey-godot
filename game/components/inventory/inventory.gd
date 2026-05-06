class_name Inventory
extends Resource

signal amount_changed
signal item_added
signal item_removed
signal equip(item)
signal unequip(item)

var itemList: ItemsList = null
#var ammo = 100
var weapons: Array[ItemsList.Weapon] = []
var armors: Array[ItemsList.Armor] = []
var consumables: Dictionary = { }
var spells: Array[ItemsList.Spell] = []
var misc: Array[ItemsList.Misc] = []
var gold = 0
var equipped_list = []


func _init(itemListNode: ItemsList) -> void:
	itemList = itemListNode


func add_item(item: ItemsList.Item, quantity: int = 1):
	if item.name == &"Gold":
		gold += item.amount
	# Add to weapons with duplicate
	elif (itemList.weapons.has(item.id)):
		for i in range(quantity):
			var newWeapon: ItemsList.Weapon = item.duplicate(true) as ItemsList.Weapon
			if (weapons.is_empty() && spells.is_empty()):
				equip.emit(newWeapon)
			weapons.append(newWeapon)
	# Add to armors with duplicate
	elif (itemList.armors.has(item.id)):
		armors.append(item)
		for i in range(quantity):
			armors.append(item.duplicate(true) as ItemsList.Weapon)
	# Add to consumable
	elif (itemList.consumables.has(item.id)):
		if (consumables.has(item.id)):
			consumables[item.id] += quantity
		else:
			consumables[item.id] = quantity
	# Add to Spells with duplicate
	elif (itemList.spells.has(item.id)):
		for i in range(quantity):
			var newSpell: ItemsList.Spell = item.duplicate(true) as ItemsList.Spell
			if (weapons.is_empty() && spells.is_empty()):
				equip.emit(newSpell)
			spells.append(newSpell)
	# Add to Miscs with duplicate
	elif (itemList.misc.has(item.id)):
		for i in range(quantity):
			misc.append(item.duplicate(true) as ItemsList.Weapon)
	else:
		return
	item_added.emit()


func add_items(items: Array):
	for item in items:
		add_item(item)


func remove_item(item: ItemsList.Item, quantity: int = 1):
	if item.id == &"goldpiece":
		gold -= quantity
	elif (weapons.has(item)):
		weapons.remove_at(weapons.find(item))
		unequip.emit(item)
	elif (armors.has(item)):
		armors.remove_at(armors.find(item))
	elif (consumables.has(item.id)):
		consumables[item.id] -= 1
		if (consumables[item.id] == 0):
			consumables.erase(item.id)
	elif (spells.has(item)):
		spells.remove_at(spells.find(item))
		unequip.emit(item)
	elif (misc.has(item)):
		misc.remove_at(misc.find(item))
	else:
		return


## Retrieve the first item having the same id given, if no item match, returns null
func get_item(itemId: String) -> ItemsList.Item:
	if itemId == &"goldpiece":
		return null # Dont need to search for an item here
	elif (itemList.weapons.has(itemId)):
		for weapon in weapons:
			if (weapon.id == itemId):
				return weapon
	elif (itemList.armors.has(itemId)):
		for armor in armors:
			if (armor.id == itemId):
				return armor
	elif (itemList.consumables.has(itemId)):
		return itemList.get_item(itemId)
	elif (itemList.spells.has(itemId)):
		for spell in spells:
			if (spell.id == itemId):
				return spell
	elif (itemList.misc.has(itemId)):
		for miscObj in misc:
			if (miscObj.id == itemId):
				return miscObj
	return null


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
		"weapons": weapons_str,
		"armors": armors_str,
		"spells": spells_str,
		"consumables": consumables,
		"misc": misc_str,
		"gold": gold,
		"equipped_list": equipped_str,
	}


func dict_to_inventory(dict: Dictionary):
	weapons = []
	armors = []
	consumables = { }
	spells = []
	misc = []
	equipped_list = []

	var weapons_str: Array[String] = dict["weapons"]
	for weapon in weapons_str:
		add_item(itemList.get_item(weapon))

	var armors_str: Array[String] = dict["armors"]
	for armor in armors_str:
		add_item(itemList.get_item(armor))

	var spells_str: Array[String] = dict["spells"]
	for spell in spells_str:
		add_item(itemList.get_item(spell))

	var misc_str: Array[String] = dict["misc"]
	for miscItem in misc_str:
		add_item(itemList.get_item(miscItem))

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
