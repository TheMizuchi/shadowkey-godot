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

func _on_take_all_pressed():
	var contents = represented_container.get_node("container").contents
	for item in contents:
		%player.add_item(item)
	hide()
	%logic.enable_fps_input()
	%player.get_node("mouselook").enable()

func _on_okay_pressed():
	pass # Replace with function body.
