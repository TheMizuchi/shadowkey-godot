extends Node

var equipment_list 
var prompt = &"Examine"
var contents = []

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_list = get_tree().get_first_node_in_group(&"equipment_list")

func set_up_contents(objects_id):
	for id in objects_id:
		contents.append(equipment_list.get_item(id))

# TODO: figure this out. Should probably work with index as player can take
# any item from the list, same items or not
func take_out_item(index):
	var item
	if index < contents.size():
		item = contents.pop_at(index)
	if contents.is_empty():
		destroy_container()
	return item
	
func take_out_all_items():
	destroy_container()
	return contents

func destroy_container():
	get_parent().remove_from_group(&"container")
