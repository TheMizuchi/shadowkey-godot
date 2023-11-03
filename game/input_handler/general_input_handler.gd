extends Node

func _input(event):
	if event.is_action_pressed("exit_game"):
		get_tree().quit()
