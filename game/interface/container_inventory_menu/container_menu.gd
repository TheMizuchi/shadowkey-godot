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
	var i = 0
	for object in objects:
		var button = Button.new()
		button.text = object.name
		button.connect("pressed", Callable(self, "_on_pressed_item").bind(button, i))
		list.add_child(button)
		i+=1

func _on_pressed_item(button, i):
		list.remove_child(button)
		%player.find_child("inventory").add_item(represented_container.get_node("container").take_out_item(i))
		if(list.get_children().is_empty()):
			close_windows()

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
	close_windows()

func close_windows():
	hide()
	%logic.resume_game()
	%logic.set_input_handler(&"fps")
