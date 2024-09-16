extends Node

#var current_handler
var pause_menu

# TODO: think about this structure
# shouldn't opening the inventory be done from FPS handler?
# since player is in FPS mode at the time?

func _ready():
	pause_menu = $"../interface/menus/pause_menu"

func _input(event):
	if event.is_action_pressed("exit_game"):
		%logic.exit_game()

	# In the orifinal Shadowkey, player could access pause menu only from
	# FPS mode. Being in other menu prevented direct access to pause menu
	if event.is_action_pressed("pause_menu"):
		if not pause_menu.visible:
			pause_menu.show()
			set_current_handler(&"menu")
			%logic.pause_game()
		else:
			# TODO: figure out how to detect what mode to return to
			pause_menu.hide()
			if not %logic.menu_is_open():
				set_current_handler(&"fps")
				%logic.resume_game()

func set_current_handler(mode):
	for node in get_children():
		node.disable()
	match mode:
		&"fps":
			$fps_input_handler.enable()
		&"menu":
			$menu_input_handler.enable()
	#current_handler = mode
