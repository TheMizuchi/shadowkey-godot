extends Node

var parent

#signal was_picked_up
var type = ""
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	type = parent.type
	value = parent.value

func on_body_entered(body):
	if body.is_in_group("characters"):
		if body.has_method("pick_up_item"):
			body.pick_up_item(type, value)
			parent.queue_free()
