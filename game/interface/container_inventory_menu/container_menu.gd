extends Node2D

# TODO: implement picking up one item at a time
var list
var represented_container
# for comparison
var bag_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	bag_scene = preload("res://game/actors/objects/dropped_bag/bag.tscn")
	list = $"Control/container/list"

func populate(objects):
	var i = 0
	for object in objects:
		var button = Button.new()
		if object.get_class_name() == &"Gold":
			button.text = str(object.amount) + " " + object.name
			# handle plural
			if object.amount > 1:
				button.text = button.text+"s"
		else:
			button.text = object.name
		button.text = object.name
		button.connect("pressed", Callable(self, "_on_pressed_item").bind(button, i))
		list.add_child(button)
		i+=1
	$very_short_timer.start()

func _on_pressed_item(button, i):
		list.remove_child(button)
		%player.find_child("inventory").add_item(represented_container.get_node("container").take_out_item(i), 1)
		if(list.get_children().is_empty()):
			close_window()
		else:
			clear_list()
			populate(represented_container.get_node("container").contents)

func set_represented_container(object):
	represented_container = object

func clear_list():
	for entry in list.get_children():
		list.remove_child(entry)

func _on_take_all_pressed():
	%player.find_child("inventory").add_items(represented_container.get_node("container").take_out_all_items())
	clear_list()
	close_window()

func close_window():
	hide()
	%logic.resume_game()
	%logic.set_input_handler(&"fps")

func _on_very_short_timer_timeout():
	# TODO: figure out how to handle this properly 
	# there should be no containers with 0 items
	if list:
		list.get_child(0).grab_focus()
