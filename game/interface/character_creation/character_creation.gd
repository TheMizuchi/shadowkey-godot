extends Node2D

var classSelection: Node2D
var raceSelection: Node2D
var nameSelection: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	classSelection = find_child("ClassSelection")
	raceSelection = find_child("RaceSelection")
	nameSelection = find_child("NameSelection")
	classSelection.show()


func _on_next_button_pressed() -> void:
	if classSelection.visible:
		classSelection.hide()
		raceSelection.show()
	elif raceSelection.visible:
		raceSelection.hide()
		nameSelection.show()
	elif nameSelection.visible:
		%hud.find_child("weapon_view").show()
		%hud.find_child("stats_display").show()
		%logic.start_game()
		self.hide()
	else:
		print("ERROR: next button pressed after name selection")
		return


func _on_previous_button_pressed() -> void:
	if classSelection.visible:
		get_parent().find_child("main_menu").show()
		hide()
	elif raceSelection.visible:
		classSelection.show()
		raceSelection.hide()
	elif nameSelection.visible:
		raceSelection.show()
		nameSelection.hide()
	else:
		print("ERROR: previous button pressed before class selection")
		return