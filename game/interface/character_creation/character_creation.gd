extends Node2D

const ClassCharacter = preload("res://game/actors/characters/player/classes.gd")
const RaceCharacter = preload("res://game/actors/characters/player/races.gd")

signal character_creation_done(classSelected: ClassCharacter.Classes, raceSelected: RaceCharacter.Races, genderSelected: bool, nameSelected: String)

@export var classSelection: Node2D
@export var raceSelection: Node2D
@export var nameSelection: Node2D
@export var nextButton: Button


var classSelected: ClassCharacter.Classes
var raceSelected: RaceCharacter.Races
var genderSelected: bool
var nameSelected: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	classSelection.show()


func _on_next_button_pressed() -> void:
	if classSelection.visible:
		classSelected = classSelection.classSelected
		classSelection.hide()
		raceSelection.show()
	elif raceSelection.visible:
		raceSelected = raceSelection.raceSelected
		raceSelection.hide()
		nameSelection.show()
	elif nameSelection.visible:
		genderSelected = nameSelection.genderSelected
		nameSelected = nameSelection.nameSelected
		character_creation_done.emit(classSelected, raceSelected, genderSelected, nameSelected)
		%hud.show()
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

func _on_name_empty(isEmpty:bool) -> void:
	nextButton.disabled = nameSelection.visible && isEmpty
