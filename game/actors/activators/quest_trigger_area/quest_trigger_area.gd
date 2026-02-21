extends Node3D
class_name QuestTriggerAreaActivator

@export var related_quest: String = ""


## When the player enter the aera, progress the quest
func _on_body_entered(body):
	#TODO filter body correctly through a calque?
	if related_quest and body.is_in_group(&"player_character"):
		var tracker = get_tree().get_first_node_in_group("quest_tracking")
		if tracker.progress_quest(related_quest):
			queue_free()
