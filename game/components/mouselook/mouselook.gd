extends Node

var enabled = true
var sensitivity = -0.003
var horisontal_roate_node
var vertical_roate_node

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	horisontal_roate_node = get_parent()
	vertical_roate_node = $"../first_person_camera"

func _input(event):
	if enabled and event is InputEventMouseMotion:
		var attempt_vertical_rotation = vertical_roate_node.rotation.x+event.relative.y*sensitivity
		var vertical_rotation = clamp(attempt_vertical_rotation,-1.2,1.3)
		horisontal_roate_node.rotate_y(event.relative.x*-0.003)
		#vertical_roate_node.rotate_x(event.relative.y*-0.003)
		vertical_roate_node.set_rotation(Vector3(vertical_rotation,0,0))

func enable():
	enabled = true

func disable():
	enabled = false
