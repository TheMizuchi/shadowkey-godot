extends RayCast3D

var target: Node3D

@onready var prompt: Prompt = get_tree().get_root().get_node("game/interface/hud/prompt")


func _physics_process(delta: float) -> void:
	var collider: Node3D = get_collider()
	if collider and collider.is_in_group(&"interactable"):
		target = collider
		prompt.show_text_for_object(target)
		prompt.show()
	elif prompt.visible:
		target = null
		prompt.clear_prompt()
		prompt.hide()
