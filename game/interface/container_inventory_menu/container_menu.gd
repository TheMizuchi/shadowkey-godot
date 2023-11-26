extends Node

# TODO: implement picking up one item at a time
var list

# Called when the node enters the scene tree for the first time.
func _ready():
	list = $Control/container/list

func populate(objects):
	for object in objects:
		print(object)
		var label = Label.new()
		label.text = object[0]
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		list.add_child(label)
