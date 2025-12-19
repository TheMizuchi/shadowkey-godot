extends Node2D

signal load_requested()

func _ready():
	pass

func _on_new_game_pressed() -> void:
	get_parent().find_child("character_creation_menu").show()
	hide()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_game_pressed() -> void:
	%logic.exit_game()


func _on_load_game_pressed() -> void:
	load_requested.emit()
	%logic.resume_game()
	hide()
