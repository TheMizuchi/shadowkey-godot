extends Node3D

const VERTICAL_VELOCITY: float = 2

var got_collision: bool = false

@onready var upper: RayCast3D = $upper
@onready var lower: RayCast3D = $lower
@onready var movement_system: MovementSystem = $"../movement_system"


## Make player raise up if walking from a lower terrain to an higher terrain
func _physics_process(_delta):
	if not movement_system.movement_vector.is_zero_approx():
		self.rotation.y = movement_system.movement_vector.angle_to(Vector2(0, -1))

	if not upper.is_colliding() and lower.is_colliding():
		# collide only with terrain (put all terrain staticbody into this group)
		if lower.get_collider() and lower.get_collider().is_in_group(&"static_terrain") and not movement_system.movement_vector.is_zero_approx():
			got_collision = true
			get_parent().velocity.y += VERTICAL_VELOCITY
	elif got_collision:
		get_parent().velocity.y = 0
		got_collision = false
