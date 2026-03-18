class_name QuestTrigger
extends Node

@export var just_progress = false
@export var related_quest: String
@export var related_stage: int
@export var dialogueId: int

@onready var quest_manager = get_tree().get_first_node_in_group("quest_tracking")


func set_related_quest_to_stage():
	quest_manager.set_quest_stage(related_quest, related_stage)


func progress_related_quests():
	# TODO change if to have a signal sent when opponent death (more clean)
	if(related_quest != ""):
		if just_progress:
			quest_manager.progress_quest(related_quest)
		else:
			set_related_quest_to_stage()
