extends Node

var is_open = false
var collision_shape

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_shape = $CollisionShape3D.shape

func activate():
	if is_open:
		$CollisionShape3D.shape = collision_shape
		$mesh.position.x = 0
		$mesh.position.z = 0
		$mesh.rotation.y = 0
	else:
		$mesh.position.x = -0.5
		$mesh.position.z = -0.5
		$mesh.rotation.y = deg_to_rad(90)
		$CollisionShape3D.shape = null
