extends Node

# TODO: find better way of doing this
# related quests = {"quest_name": {stage: dialogue] } }
# related_quests = {"ratquest" : {0: 42, 1: 1337, 2: 9001 } }
@export var related_quests = {}
@export var dialogues = []
var last_dialogue = 0
var dialogue_menu
var quest_tracking

func _ready():
	dialogue_menu = get_tree().get_first_node_in_group(&"dialogue_menu")
	quest_tracking = get_tree().get_first_node_in_group(&"quest_tracking")

func display_dialogue():
	for quest in related_quests.keys():
		#if not quest_tracking.is_quest_completed(quest):
		var current_stage = quest_tracking.get_quest_stage(quest)
		for stage in related_quests[quest].keys():
			if current_stage == stage:
				dialogue_menu.show_dialogue(related_quests[quest][stage])
				break
		break
	if dialogues:
		dialogue_menu.show_dialogue(dialogues[last_dialogue])
