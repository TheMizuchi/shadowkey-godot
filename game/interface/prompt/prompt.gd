extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_prompt():
	$label.show()

func hide_prompt():
	$label.hide()

func set_text(text):
	$label.text = text

func clear_prompt():
	$label.text = ""

func show_text_for_object(object):
	var groups = object.get_groups()
	for group in groups:
		match group:
			&"container":
				set_text(&"Examine")
			&"character":
				set_text(object.prompt)
			&"custom_prompt":
				set_text(object.prompt)
		
