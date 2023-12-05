extends Node

var prompt = &"Examine"
var contents = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_up_contents(object_names):
	contents = object_names

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
