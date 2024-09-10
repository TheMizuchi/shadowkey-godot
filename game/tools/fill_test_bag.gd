extends Node

@export var object_ids = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_bag()

func fill_bag():
	var objects = []
	for object_id in object_ids:
		var amount = 1
		if object_id == &"gold":
			amount = randi_range(5,20)
		var object = get_tree().get_first_node_in_group(&"item_list")\
		.get_item(object_id, amount)
		objects.append(object)
	get_parent().get_node("container").set_up_contents(objects)
