extends Node


# TODO: should set_process_input(false) be the solution for this?
var enabled = false
var player_character
var weapon_view
var stats_view
var current_equip

# Called when the node enters the scene tree for the first time.
func _ready():
	player_character = get_tree().get_first_node_in_group("player_character")
	weapon_view = $"../../interface/hud/weapon_view"
	stats_view = $"../../interface/hud/stats_display"
	current_equip = $"../../logic/equipment_list".weapons["irondagger"]
	enable()
	
func _physics_process(delta):
	if enabled:
		var movement_vector = Input.get_vector("left", "right", "forward", "backwards")
		player_character.set_movement_vector(movement_vector)
		if Input.is_action_just_pressed("ui_accept"):
			player_character.jump()
			stats_view.update_stats()


func _input(event):
	if enabled:
		if event.is_action_pressed("action1"):
			if weapon_view.is_animation_finished():
				player_character.use_equip()
				stats_view.update_stats()
				weapon_view.play_animation()
		if event.is_action_pressed("action2"):
			select_next_equip()
			#player_character.shoot_projectile()
		if event.is_action_pressed("cycle_weapon"):
			select_next_equip()
		# TODO: figure out how to untangle this mess
		#$"../../game_logic/fps".update_ammo_count()


func enable():
	enabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	player_character.enable_control()

func disable():
#	player_character.set_movement_vector(Vector2(0,0))
#	player_character.disable_control()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	enabled = false

#TODO: figure out where this function should actually be
func select_next_equip():
	#print(player_character.weapon_list.size())
	for index in range(player_character.equipped_list.size()):
		if current_equip == player_character.equipped_list[index]:
			if index < player_character.equipped_list.size()-1:
				current_equip = player_character.equipped_list[index+1]
			else:
				current_equip = player_character.equipped_list[0]
			player_character.set_current_equip(current_equip)
			weapon_view.set_weapon(current_equip)
			break

func _on_animation_finished():
	player_character.use_equip()
	stats_view.update_stats()
