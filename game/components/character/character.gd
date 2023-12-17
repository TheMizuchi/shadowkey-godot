extends Node

@export var prompt = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(&"interactable")
	add_to_group(&"character")
	$idle/AnimationPlayer.play("KeyAction")

func activate():
	if has_node("has_dialogue"):
		var node = get_node("has_dialogue")
		node.display_dialogue()
		
	#$quest_trigger.progress_related_quests()
