extends Node

var parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()

#const JUMP_VELOCITY = 4.5
const JUMP_VELOCITY = 5.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func jump():
	parent_node.velocity.y = JUMP_VELOCITY

#TODO: lol this is messed up, should be handled by input handled
func _physics_process(_delta):
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and parent_node.is_on_floor():
		jump()
