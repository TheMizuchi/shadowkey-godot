extends Node2D

# TODO: implement picking up one item at a time
var list
var equipment_list
var represented_container

# Called when the node enters the scene tree for the first time.
func _ready():
	list = $Control/container/list
	equipment_list = get_tree().get_first_node_in_group(&"equipment_list")

func populate(objects):
	for object in objects:
		var item = equipment_list.get_item(object)
		if(item):
			var button = Button.new()
			button.text = item[0]
			list.add_child(button)

func set_represented_container(object):
	represented_container = object

func clear_list():
	for entry in list.get_children():
		list.remove_child(entry)

func _on_okay_pressed():
	pass # Replace with function body.

func _on_take_all_pressed():
	%player.find_child("inventory").add_items(represented_container.get_node("container").take_out_all_items())
	clear_list()
	hide()
	# TODO: lol all of this should be placed into more appropriate nodes
	%logic.enable_fps_input()
	%player.get_node("mouselook").enable()
