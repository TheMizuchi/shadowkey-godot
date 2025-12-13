extends Node2D

const RaceCharacter = preload("res://game/actors/characters/player/races.gd")

var raceSelected: RaceCharacter.Races

var raceNameLabel: Label
var raceDescLabel: RichTextLabel

var previousButton: Button
var nextButton: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raceSelected = RaceCharacter.Races.ARGONIAN
	raceNameLabel = find_child("Race")
	raceDescLabel = find_child("Description")
	previousButton = find_child("RacePrevious")
	nextButton = find_child("RaceNext")
	changeRaceSelection()

func _on_race_next_pressed() -> void:
	if(raceSelected == RaceCharacter.Races.ARGONIAN):
		previousButton.show();
	raceSelected += 1
	if(raceSelected == RaceCharacter.Races.WOODELF):
		nextButton.hide();
	changeRaceSelection()

func _on_race_previous_pressed() -> void:
	if(raceSelected == RaceCharacter.Races.WOODELF):
		nextButton.show();
	raceSelected -= 1
	if(raceSelected == RaceCharacter.Races.ARGONIAN):
		previousButton.hide();
	changeRaceSelection()


func changeRaceSelection() -> void:
	var file = FileAccess.open("res://game/assets/data/races.json", FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	
	var raceName: String = ""
	var raceDesc: String = ""
	match raceSelected:
		RaceCharacter.Races.ARGONIAN:
			raceDesc = result["argonian"]["description"]
			raceName = "Argonian"
		RaceCharacter.Races.BRETON:
			raceDesc = result["breton"]["description"]
			raceName = "Breton"
		RaceCharacter.Races.DARKELF:
			raceDesc = result["darkelf"]["description"]
			raceName = "Dark Elf"
		RaceCharacter.Races.HIGHELF:
			raceDesc = result["highelf"]["description"]
			raceName = "High Elf"
		RaceCharacter.Races.KHAJIIT:
			raceDesc = result["khajiit"]["description"]
			raceName = "Khajiit"
		RaceCharacter.Races.NORD:
			raceDesc = result["nord"]["description"]
			raceName = "Nord"
		RaceCharacter.Races.REDGUARD:
			raceDesc = result["redguard"]["description"]
			raceName = "Redguard"
		RaceCharacter.Races.WOODELF:
			raceDesc = result["woodelf"]["description"]
			raceName = "Wood Elf"
		_:
			print("Unexpected class given")
			return
	raceNameLabel.text = raceName
	raceDescLabel.text = raceDesc
