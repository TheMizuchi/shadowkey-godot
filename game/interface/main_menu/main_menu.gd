extends Node2D

func _ready():
	pass

func _on_new_game_pressed() -> void:
	%logic.start_game()
	hide()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_game_pressed() -> void:
	%logic.exit_game()
