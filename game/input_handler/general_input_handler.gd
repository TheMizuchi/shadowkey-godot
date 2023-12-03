extends Node

var current_handler

func _input(event):
	if event.is_action_pressed("exit_game"):
		get_tree().quit()

	#if event.is_action_pressed("pause_game"):
		#%logic.show_pause_menu()

func set_current_handler(mode):
	pass
