extends Node

signal fall_damage(vertical_velocity)

# TODO: figure out how to split this into ECS
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var ROTATION_SPEED = 1.0
@export var check_for_fall_damage = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#var gravity = 0.1
var parent_node
var movement_vector = Vector2()
var target_node
var landed = false
var move_towards_target = true
var max_y_velocity = 0

# TODO: figure out how to save cpu cycles by having movement code in an if block

func _ready():
	parent_node = get_parent()

func look_towards_position(position):
	parent_node.look_at(Vector3(position.x,parent_node.get_position().y,position.z))

func get_direction_to_position(position):
	return parent_node.get_position().direction_to(position)

func _physics_process(delta):
	if check_for_fall_damage:
		match parent_node.get_slide_collision_count():
			0:
				if landed:
					landed = false
				# > because we are comparing to -velocity, which we will abs() later
				if max_y_velocity > parent_node.velocity.y:
					max_y_velocity = parent_node.velocity.y
			1:
				if not landed:
					landed = true
					fall_damage.emit(abs(max_y_velocity))
					max_y_velocity = 0
	
	var direction
	if target_node:
		var node_position = target_node.get_position()
		look_towards_position(node_position)
		if move_towards_target:
			direction = get_direction_to_position(node_position)

	if direction == null:
		direction = (parent_node.transform.basis * Vector3(movement_vector.x, 0, movement_vector.y)).normalized()
	# make character move
	var on_floor = parent_node.is_on_floor()
	if direction or parent_node.velocity.y != 0 or not on_floor:
		if not on_floor:
			parent_node.velocity.y -= gravity * delta
		parent_node.velocity.x = direction.x * SPEED
		parent_node.velocity.z = direction.z * SPEED
		parent_node.move_and_slide()
	# make character stop
	elif parent_node.velocity.x != 0 and parent_node.velocity.z != 0:
		parent_node.velocity.x = 0
		parent_node.velocity.z = 0

func stop_moving():
	move_towards_target = false

func resume_moving():
	move_towards_target = true

func clear_target_node():
	target_node = null
