extends Node

var prompt = &"Examine"
var contents = []
var equipment_list

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_list = get_tree().get_first_node_in_group(&"equipment_list")

func set_up_contents(object_names):
	for object_name in object_names:
		for category in [equipment_list.weapons, equipment_list.spells, \
		equipment_list.consumables]:
			if object_name in category.keys():
				contents.append(category[object_name])

# TODO: figure this out. Should probably work with index as player can take
# any item from the list, same items or not
func take_out_item(index):
	var item
	if index < contents.size():
		item = contents.pop_at(index)
	if contents.is_empty():
		destroy_container()
	return item

func destroy_container():
	get_parent().remove_from_group(&"container")
