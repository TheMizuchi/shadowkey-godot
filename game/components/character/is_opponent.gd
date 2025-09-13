extends Node

# TODO: this feels wrong. Component should not directly interact with another compoment
# Entity's script should take care of that.
# Also, feels way too similar to opponent.gd. Where is the limit?
# should be merged. Will be merged.
#TODO: Paint red by changing Surface 0 albeio instead of doing material override

var player
var awake = false
var movement_vector = Vector2()
var attack_cooldown_timer = Timer.new()
#var damage_indicator_timer = Timer.new()
#var red = preload("res://game/assets/red_material/red_material_3d.tres")
var hit_sprite = preload("res://game/misc/blood_sprite/blood_sprite.tscn")

func _ready():
	add_to_group(&"characters")
	player = get_tree().get_first_node_in_group(&"player_character")
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

func draw_hit_sprite(height=1.5):
	var sprite = hit_sprite.instantiate()
	var parent_position = get_parent().position
	sprite.position = parent_position+Vector3(0,height,0)
	#get_parent().add_child(sprite)
	add_child(sprite)
