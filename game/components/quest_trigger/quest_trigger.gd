extends Node

@export var just_progress = false
@export var related_quests = {}
var tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	tracker = get_tree().get_first_node_in_group("quest_tracking")

func set_related_quest_to_stage():
	for quest_name in related_quests.keys():
		tracker.set_quest_stage(quest_name, related_quests[quest_name])

func progress_related_quests():
	if just_progress:
		for quest_name in related_quests.keys():
			tracker.progress_quest(quest_name)
	else:
		set_related_quest_to_stage()
