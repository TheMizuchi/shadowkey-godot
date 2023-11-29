extends Node

@export var prompt = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("interactable")
	add_to_group("character")

func activate():
	$quest_trigger.progress_related_quests()
