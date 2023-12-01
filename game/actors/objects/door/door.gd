extends Node

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate():
	$mesh.position.x = -0.5
	$mesh.position.z = -0.5
	$mesh.rotation.y = deg_to_rad(90)
