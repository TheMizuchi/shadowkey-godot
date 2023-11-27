extends Node


# TODO: should set_process_input(false) be the solution for this?
var enabled = false
#var player_character
var weapon_view
var stats_view
var current_equip
var container_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	#player_character = get_tree().get_first_node_in_group("player_character")
	weapon_view = $"../../interface/hud/weapon_view"
	stats_view = $"../../interface/hud/stats_display"
	container_menu = $"../../interface/menus/container_menu"
	current_equip = $"../../logic/equipment_list".weapons["irondagger"]
	enable()
	
func _physics_process(delta):
	if enabled:
		var movement_vector = Input.get_vector("left", "right", "forward", "backwards")
		%player.set_movement_vector(movement_vector)
		if Input.is_action_just_pressed("ui_accept"):
			%player.jump()
			stats_view.update_stats()

func _input(event):
	if not enabled:
		return false
	if event.is_action_pressed("action1"):
		if weapon_view.is_animation_finished():
			if %player.current_equip:
				%player.use_equip()
				stats_view.update_stats()
				weapon_view.play_animation()
	if event.is_action_pressed("action2"):
		select_next_equip()
		#%player.shoot_projectile()
	if event.is_action_pressed("cycle_weapon"):
		select_next_equip()
	if event.is_action_pressed("activate_object"):
		# TODO: this should not be done here
		var object = %player.activate_object()
		if object and object.is_in_group(&"container"):
			disable()
			%player.set_movement_vector(Vector3())
			var container_component = object.get_node("container")
			container_menu.set_represented_container(object)
			container_menu.populate(container_component.contents)
			container_menu.show()
			%player.get_node("mouselook").disable()


func enable():
	enabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	%player.enable_control()

func disable():
#	%player.set_movement_vector(Vector2(0,0))
#	%player.disable_control()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	enabled = false

#TODO: figure out where this function should actually be
func select_next_equip():
	#print(%player.weapon_list.size())
	for index in range(%player.equipped_list.size()):
		if current_equip == %player.equipped_list[index]:
			if index < %player.equipped_list.size()-1:
				current_equip = %player.equipped_list[index+1]
			else:
				current_equip = %player.equipped_list[0]
			%player.set_current_equip(current_equip)
			weapon_view.set_weapon(current_equip)
			break

func _on_animation_finished():
	%player.use_equip()
	stats_view.update_stats()
