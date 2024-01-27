extends Node

@export var object_ids = []

var container_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	var objects = []
	for object_id in object_ids:
		var object = get_tree().get_first_node_in_group(&"item_list")\
		.get_item(object_id)
		objects.append(object)
	$container.set_up_contents(objects)
	container_menu = $"../../interface/menus/container_menu"

func activate():
	print(%player)
	%player.set_movement_vector(Vector3())
	var container_component = get_node("container")
	container_menu.set_represented_container(self)
	container_menu.populate(container_component.contents)
	container_menu.show()
	%logic.pause_game()
	%player.get_node("mouselook").disable()
