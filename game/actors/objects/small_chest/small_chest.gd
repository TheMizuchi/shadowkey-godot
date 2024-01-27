extends Node

@export var object_ids = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var objects = []
	for object_id in object_ids:
		var object = get_tree().get_first_node_in_group(&"item_list")\
		.get_item(object_id)
		objects.append(object)
	$container.set_up_contents(objects)

func activate():
	pass
