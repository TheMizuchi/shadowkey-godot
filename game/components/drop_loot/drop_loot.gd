extends Node

@export var vertical_offset = 0.0
# [item, chance] 
var loot_table = []
#var bag_scene_path = "res://game/actors/objects/dropped_bag/bag.tscn"
var bag_scene

func _ready():
	bag_scene = preload("res://game/actors/objects/dropped_bag/bag.tscn")

func add_to_loot_table(item, chance):
	loot_table.append([item, chance])

func drop_loot():
	#var bag_scene = load(bag_scene_path)
	var item_list = []
	# TODO: actually do the RNG thing
	for item in loot_table:
		item_list.append(item[0])
	if item_list.size() > 0:
		var bag = bag_scene.instantiate()
		bag.get_node("container").set_up_contents(item_list)
		bag.position = get_parent().position+Vector3(0,vertical_offset,0)
		get_tree().root.add_child(bag)
