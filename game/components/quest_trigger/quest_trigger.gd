extends Node

@export var related_quests = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func progress_related_quests():
	var tracker = get_tree().get_first_node_in_group("quest_tracking")
	for quest_name in related_quests:
		tracker.progress_quest(quest_name)
