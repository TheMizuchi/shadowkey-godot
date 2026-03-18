extends Node3D

@export var related_quest: String = ""
@export var related_stage: int = 0
@export var dialogId: int = 0

@onready var dialogueManager = get_node("/root/game/logic/dialogues_manager")
@onready var dialogueMenu = get_node("/root/game/interface/menus/dialogue_menu")
@onready var questManager = get_node("/root/game/logic/quest_manager")

## When the player enter the aera, progress the quest
func _on_body_entered(body):
	#TODO filter body correctly through a calque?
	if related_quest and body.is_in_group(&"player_character"):
		dialogueMenu.show_dialogue(dialogueManager.get_dialogue(dialogId))
		var questManager: QuestManager = questManager
		if questManager.progress_quest(related_quest):
			queue_free()
