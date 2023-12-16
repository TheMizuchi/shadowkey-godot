extends Node

@export var dialogues = []
var last_dialogue = 0
var dialogue_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_menu = get_tree().get_first_node_in_group(&"dialogue_menu")

func display_dialogue():
	dialogue_menu.show_dialogue(dialogues[last_dialogue])
