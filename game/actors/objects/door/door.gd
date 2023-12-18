extends Node

var prompt
var open_door_prompt = &"Open door"
var close_door_prompt = &"Close door"
var is_open = false
var collision_shape
var original_rotation

var prompt_hud_node

# Called when the node enters the scene tree for the first time.
func _ready():
	prompt = open_door_prompt
	collision_shape = $collision/shape.shape
	original_rotation = $collision/mesh.rotation.y
	prompt_hud_node = get_tree().root.get_node("game/interface/hud/prompt")

func activate():
	if is_open:
		$collision/mesh.show()
		$collision/shape.shape = collision_shape
		$collision/mesh.position.x = 1.02
		$collision/mesh.position.z = 0.02
		$collision/mesh.rotation.y = original_rotation
		prompt = open_door_prompt
		is_open = false
	else:
		$collision/mesh.position.x = 0.9
		$collision/mesh.position.z = -0.5
		$collision/mesh.rotation.y = deg_to_rad(90)
		#$collision/mesh.hide()
		$collision/shape.shape = null
		prompt = close_door_prompt
		is_open = true
	prompt_hud_node.show_text_for_object.call_deferred(self)
