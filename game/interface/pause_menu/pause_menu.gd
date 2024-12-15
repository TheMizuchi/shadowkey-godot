extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func resume_game():
	%logic.set_input_handler(&"fps")
	%logic.resume_game()
	self.hide()

func _on_resume_pressed() -> void:
	resume_game()

func _on_load_game_pressed() -> void:
	pass # Replace with function body.

func _on_save_game_pressed() -> void:
	pass # Replace with function body.

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_debug_menu_pressed() -> void:
	pass # Replace with function body.
	
func _on_main_menu_pressed() -> void:
	pass # Replace with function body.

func _on_exit_to_os_pressed() -> void:
	%logic.exit_game()
