extends Node


# TODO: should set_process_input(false) be the solution for this?
var enabled = false
var player_character
var weaponview
var attack_ready = true
var current_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	player_character = get_tree().get_first_node_in_group("player_character")
	weaponview = $"../../interface/hud/weapon_view"
	current_weapon = "dagger"
	enable()
	
func _process(_delta):
	if enabled:
		var movement_vector = Input.get_vector("left", "right", "forward", "backwards")
		player_character.set_movement_vector(movement_vector)

func _input(event):
	if enabled:
		if event.is_action_pressed("action1"):
			#player_character.shoot_hitscan()
			weaponview.play_animation()
			attack_ready = false
		if event.is_action_pressed("action2"):
			select_next_weapon()
			#player_character.shoot_projectile()
		if event.is_action_pressed("cycle_weapon"):
			select_next_weapon()
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
func select_next_weapon():
	#print(player_character.weapon_list.size())
	for index in range(player_character.weapon_list.size()):
		if current_weapon == player_character.weapon_list[index]:
			if index < player_character.weapon_list.size()-1:
				current_weapon = player_character.weapon_list[index+1]
				weaponview.set_weapon(current_weapon)
				break
			else:
				current_weapon = player_character.weapon_list[0]
				weaponview.set_weapon(current_weapon)
				break

func _on_animation_finished():
	if current_weapon == "spell":
		player_character.shoot_projectile()
	else:
		player_character.shoot_hitscan()
	attack_ready = true
