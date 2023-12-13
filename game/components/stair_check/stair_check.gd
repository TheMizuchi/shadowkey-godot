extends Node

@export var vertical_velocity = 0.7
var got_collision
var upper
var lower

func _ready():
	upper = $upper
	lower = $lower

# make player raise up if walking into a low terrain
func _physics_process(_delta):
	if not upper.is_colliding() and lower.is_colliding():
		# collide only with terrain (put all terrain staticbody into this group)
		if lower.get_collider() and lower.get_collider().is_in_group(&"static_terrain") \
		# raise player only when pressing forward
		and $"../movement_system".movement_vector.y < 0:
			got_collision = true
			get_parent().velocity.y += vertical_velocity
	elif got_collision:
		get_parent().velocity.y = 0
		got_collision = false
