extends Node

# TODO: should set_process_input(false) be the solution for this?
var enabled = false
var weapon_view
var stats_view
var container_menu
var inventory 

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_view = $"../../interface/hud/weapon_view"
	stats_view = $"../../interface/hud/stats_display"
	container_menu = $"../../interface/menus/container_menu"
	
func _physics_process(_delta):
	if not enabled:
		return 
	var movement_vector = Input.get_vector(&"left", &"right", &"forward", &"backwards")
	%player.set_movement_vector(movement_vector)
	if Input.is_action_just_pressed(&"jump"):
		%player.jump()
		stats_view.update_stats()

func _input(event):
	if not enabled or get_tree().paused:
		return 
	if event.is_action_pressed(&"action1"):
		if weapon_view.is_animation_finished() && %player.current_equip:
				if(%player.use_equip()):
					stats_view.update_stats()
					weapon_view.play_animation()
	if event.is_action_pressed(&"action2"):
		select_next_equip()
	if event.is_action_pressed(&"cycle_weapon"):
		select_next_equip()
	if event.is_action_pressed(&"activate_object"):
		# TODO: this should not be done here
		var object = %player.activate_object()
		if object and object.is_in_group(&"container"):
			disable()
			%player.set_movement_vector(Vector3())
			var container_component = object.get_node("container")
			container_menu.set_represented_container(object)
			container_menu.populate(container_component.contents)
			container_menu.show()
			%logic.pause_game()
			%player.get_node("mouselook").disable()
	if event.is_action_pressed(&"go_to_test_level"):
		%logic.change_level("testchamber")

func enable():
	enabled = true
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	%player.get_node("mouselook").enable()
	%player.enable_control()

func disable():
	%player.set_movement_vector(Vector2(0,0))
	%player.disable_control()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	%player.get_node("mouselook").disable()
	enabled = false

# TODO: figure out where this function should actually be
# TO DO: handle null equip TODO: apparently already handled?
# TODO: implement consumables queue, as noted in kanban.txt
func select_next_equip():
	var equipped_list = %player.equipped_list
	var index = 0
	for i in range(equipped_list.size()):
		if(equipped_list[i] == %player.current_equip):
			index = i
			break
	var new_equip
	if equipped_list:
		if equipped_list[index] == equipped_list[-1]:
			new_equip = equipped_list[0]
		elif index < equipped_list.size():
			new_equip = equipped_list[index+1]
		if new_equip:
			%player.set_current_equip(new_equip)
			weapon_view.set_weapon(new_equip)

func _on_animation_finished():
	%player.use_equip()
	stats_view.update_stats()
