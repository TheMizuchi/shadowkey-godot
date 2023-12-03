extends Node2D

# TODO: implement picking up one item at a time
var list
var represented_container

# Called when the node enters the scene tree for the first time.
func _ready():
	list = $Control/container/list

func populate(objects):
	for object in objects:
		var label = Label.new()
		label.text = object[0]
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		list.add_child(label)

func set_represented_container(object):
	represented_container = object

func clear_list():
	for entry in list.get_children():
		list.remove_child(entry)

func _on_okay_pressed():
	pass # Replace with function body.

func _on_take_all_pressed():
	var contents = represented_container.get_node("container").contents
	# reverse because take_out_item() does array.pop(), and that messes up index sequence
	# while doing it in reverse nicely takes out end of array without messing up order
	var array_range = range(contents.size())
	array_range.reverse()
	for i in array_range:
		%player.add_item(represented_container.get_node("container").take_out_item(i))
	#for item in contents:
		#%player.add_item(item)
	# TODO: lol all of this should be placed into more appropriate nodes
	contents.clear()
	clear_list()
	hide()
	%logic.set_input_handler(&"fps")
