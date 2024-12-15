extends Node

var parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()

#const JUMP_VELOCITY = 4.5
const JUMP_VELOCITY = 5.5

func jump():
	if parent_node.is_on_floor():
		increase_vertical_velocity()
		return true
		
func increase_vertical_velocity():
	parent_node.velocity.y = JUMP_VELOCITY
