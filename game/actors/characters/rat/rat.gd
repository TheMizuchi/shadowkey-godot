extends CharacterBody3D

@export var max_health = 30

var player
var awake = false
var movement_vector = Vector2()
var attack_cooldown_timer = Timer.new()
var damage_indicator_timer = Timer.new()
var red = preload("res://game/assets/red_material/red_material_3d.tres")

# TODO: lol this is being repeated in every opponent class
# find a way to ECS this harder
func _ready():
	player = get_tree().get_nodes_in_group("player_character")[0]
	damage_indicator_timer.one_shot = true
	damage_indicator_timer.wait_time = 0.2
	damage_indicator_timer.timeout.connect(clear_red)
	add_child(damage_indicator_timer)
	
func wake_up():
	$movement_system.target_node = player

func set_movement_vector(vector):
	$movement_system.movement_vector = vector

func take_damage(amount):
	$health_system.reduce_health(amount)
	paint_red()

func paint_red():
	$mesh.material_override = red
	damage_indicator_timer.start()

func clear_red():
	$mesh.material_override = null

func _on_health_system_health_depleted():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#if awake:
		#move_towards_player()
