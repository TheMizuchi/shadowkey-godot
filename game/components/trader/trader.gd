extends Node

var inventory: Inventory

@onready var npcID = get_parent().npcID
@onready var playerInvetory: Inventory = get_tree().root.get_node("game/world/actors/player").inventory
@onready var itemList: ItemsList = get_tree().root.get_node("game/logic/item_list")


func _ready() -> void:
	inventory = Inventory.new(itemList)
	var inventoryInit: Dictionary = get_tree().root.get_node("game/logic/npc_manager").getNpcInventory(npcID)
	for item: String in inventoryInit:
		inventory.add_item(itemList.get_item(item), int(inventoryInit[item]))


func sell_to_player(itemId: String) -> void:
	var item: ItemsList.Item = inventory.get_item(itemId)
	if item == null:
		print("Trying to sell an item without owning one")
		return
	playerInvetory.add_item(item)
	playerInvetory.remove_item(ItemsList.Gold.new(item.sell_price))
	inventory.remove_item(item)


func buy_from_player(itemId: String) -> void:
	var item: ItemsList.Item = playerInvetory.get_item(itemId)
	if item == null:
		print("Trying to buy an item without the player owning one")
		return
	playerInvetory.remove_item(item)
	playerInvetory.add_item(ItemsList.Gold.new(item.buy_price))
	inventory.add_item(item)
