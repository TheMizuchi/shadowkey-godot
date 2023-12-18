extends CharacterBody3D

@export var prompt = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(&"interactable")
	add_to_group(&"character")
	# TODO: make character play first animation, regardless of name
	$idle/AnimationPlayer.play("KeyAction")

func look_at_player(angle, quick):
	$face_player.look_at_player(angle, quick)

func activate():
	if has_node("has_dialogue"):
		var node = get_node("has_dialogue")
		node.display_dialogue()
		
	#$quest_trigger.progress_related_quests()
