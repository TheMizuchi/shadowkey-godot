extends Node

var parent_node
var ground_detection_ray

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	ground_detection_ray = parent_node.get_node("ground_check")

#const JUMP_VELOCITY = 4.5
const JUMP_VELOCITY = 5.5

func jump():
	if parent_node.is_on_floor() or ground_detection_ray.is_colliding():
		increase_vertical_velocity()
		return true
		
func increase_vertical_velocity():
	parent_node.velocity.y = JUMP_VELOCITY
