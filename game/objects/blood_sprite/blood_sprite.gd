extends Node3D

# TODO: this has an issue where it is seen through map geometry
# due to no-depth-test. Consider better implementation

var disappear_timer = Timer.new()

func _ready():
	add_child(disappear_timer)
	disappear_timer.wait_time = 0.2
	disappear_timer.timeout.connect(disappear)
	disappear_timer.start()

func disappear():
	queue_free()
