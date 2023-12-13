extends Node

#TODO: Paint red by changing Surface 0 albeio instead of doing material override

var player
var awake = false
var movement_vector = Vector2()
var attack_cooldown_timer = Timer.new()
#var damage_indicator_timer = Timer.new()
#var red = preload("res://game/assets/red_material/red_material_3d.tres")
var hit_sprite = preload("res://game/misc/blood_sprite/blood_sprite.tscn")

func _ready():
	add_to_group("characters")
	player = get_tree().get_first_node_in_group("player_character")
	#damage_indicator_timer.one_shot = true
	#damage_indicator_timer.wait_time = 0.2
	#damage_indicator_timer.timeout.connect(clear_red)
	#add_child(damage_indicator_timer)

func wake_up():
	if not awake:
		$"../movement_system".target_node = player
		awake = true
	return awake

func set_movement_vector(vector):
	$"../movement_system".movement_vector = vector

## TODO: change material0 albiedo instead of doing surface override
#func paint_red():
	#$"../mesh".material_override = red
	#damage_indicator_timer.start()
#
#func clear_red():
	#$"../mesh".material_override = null

func draw_hit_sprite(height=1.5):
	var sprite = hit_sprite.instantiate()
	var parent_position = get_parent().position
	sprite.position = parent_position+Vector3(0,height,0)
	#get_parent().add_child(sprite)
	add_child(sprite)

