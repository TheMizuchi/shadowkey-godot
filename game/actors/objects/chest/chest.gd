extends Node

@export var object_names = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$container.set_up_contents(object_names)

func activate():
	pass
