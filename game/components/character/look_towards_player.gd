extends Node

@export var fluid = false

var update_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func look_at_player(angle, turn_quickly):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if fluid:
		pass
