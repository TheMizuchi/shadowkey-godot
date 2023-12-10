extends Node2D

# TODO: implement picking up one item at a time
var list
var represented_container
#var item_list
# for comparison
var bag_scene
#var gold

# Called when the node enters the scene tree for the first time.
func _ready():
	bag_scene = preload("res://game/actors/objects/dropped_bag/bag.tscn")
	#item_list = get_tree().get_first_node_in_group(&"item_list")
	#gold = item_list.Gold 
	list = $"Control/container/list"

func populate(objects):
	for object in objects:
		# TODO: figure out this RefCounted stuff and why .get_class() doesn't work
		var label = Label.new()
		if object.get_class_name() == &"Gold":
			label.text = str(object.amount) + " " + object.name
			# handle plural
			if object.amount > 1:
				label.text = label.text+"s"
		else:
			label.text = object.name
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
	# TODO: lol all of this should be placed into more appropriate nodes
	contents.clear()
	clear_list()
	hide()
	%logic.resume_game()
	%logic.set_input_handler(&"fps")
