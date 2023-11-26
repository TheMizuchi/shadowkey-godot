extends Node

# TODO: Figure out a better way to implement this in-font-of-player detection

var prompt
var current_object

# Called when the node enters the scene tree for the first time.
func _ready():
	prompt = get_tree().get_root().get_node("game/interface/hud/prompt")

func _on_area_entered(area):
	# TODO: bad group name
	if area.is_in_group(&"interactable"):
		current_object = area
		prompt.set_text(area.prompt)

func _on_area_exited(area):
	prompt.clear_prompt()
	current_object = null
	#TODO: check for other areas

func _on_body_entered(body):
	if body.is_in_group(&"interactable"):
		current_object = body

func _on_body_exited(body):
	prompt.clear_prompt()
	current_object = null
