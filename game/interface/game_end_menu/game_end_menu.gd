extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_load_game_pressed() -> void:
	pass # Replace with function body.

func _on_main_menu_pressed() -> void:
	%logic.show_main_menu()
	hide()
