extends Node

@export var smooth = false
@export var update_interval = 0.1 # in seconds
@export var rotation_stage_increase = 0.1

var target_angle
var parent
var completed_rotation_stages = 0
var update_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(update_timer)
	parent = get_parent()
	target_angle = parent.rotation.y
	if not smooth:
		set_physics_process(false)
		update_timer.wait_time = update_interval
		update_timer.timeout.connect(_on_timeout)

func look_at_player(angle, turn_quickly):
	target_angle = angle
	if abs(parent.rotation.y - target_angle) < 0.01:
		update_timer.stop()
		return
	if turn_quickly:
		# TODO: dehardcode, find appropriate variable name
		rotation_stage_increase = 0.3
	else:
		rotation_stage_increase = 0.1
	completed_rotation_stages = 0
	if smooth:
		set_physics_process(true)
	else:
		update_timer.start()

func rotate():
	parent.rotation = parent.rotation.lerp(Vector3(0,target_angle,0), completed_rotation_stages)
	completed_rotation_stages += rotation_stage_increase

func _physics_process(_delta):
	if smooth:
		pass

func _on_timeout():
	rotate()
