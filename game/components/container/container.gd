extends Node

@export var delete_when_empty = false
var prompt = &"Examine"
var contents = []

# put in actual objects instead of just object names
func set_up_contents(objects):
	for object in objects:
		contents.append(object)

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
	if delete_when_empty:
		get_parent().queue_free()
