extends Node

# TODO: Figure out a better way to implement this in-font-of-player detection
var prompt
var object_queue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	prompt = get_tree().get_root().get_node("game/interface/hud/prompt")

func handle_entry(object):
	if object.is_in_group(&"interactable") and object not in object_queue:
		object_queue.append(object)
		prompt.show_text_for_object(object)

func handle_exit(object):
	if object_queue.is_empty():
		prompt.clear_prompt()
	object_queue.erase(object)

func _on_area_entered(area):
	handle_entry(area)

func _on_area_exited(area):
	handle_exit(area)
	
func _on_body_entered(body):
	handle_entry(body)

func _on_body_exited(body):
	handle_exit(body)
