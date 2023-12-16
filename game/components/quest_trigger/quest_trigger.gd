extends Node

@export var related_quests = []
var tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = get_tree().get_first_node_in_group("quest_tracking")
	
func set_related_quest_to_stage(stage):
	for quest_name in related_quests:
		tracker.set_quest_stage(quest_name, stage)

func progress_related_quests():
	for quest_name in related_quests:
		tracker.progress_quest(quest_name)
