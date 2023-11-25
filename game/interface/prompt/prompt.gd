extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_prompt():
	$label.show()

func hide_prompt():
	$label.hide()

func set_prompt_text(text):
	$label.text = text
