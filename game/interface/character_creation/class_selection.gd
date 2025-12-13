extends Node2D

const ClassCharacter = preload("res://game/actors/characters/player/classes.gd")

@export var classSelected: ClassCharacter.Classes

var classNameLabel: Label
var classDescLabel: RichTextLabel

var previousButton: Button
var nextButton: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	classSelected = ClassCharacter.Classes.ASSASSIN
	classNameLabel = find_child("Class")
	classDescLabel = find_child("Description")
	previousButton = find_child("ClassPrevious")
	nextButton = find_child("ClassNext")
	changeClassSelection()

func _on_class_next_pressed() -> void:
	if(classSelected == ClassCharacter.Classes.ASSASSIN):
		previousButton.show();
	classSelected += 1
	if(classSelected == ClassCharacter.Classes.THIEF):
		nextButton.hide();
	changeClassSelection()

func _on_class_previous_pressed() -> void:
	if(classSelected == ClassCharacter.Classes.THIEF):
		nextButton.show();
	classSelected -= 1
	if(classSelected == ClassCharacter.Classes.ASSASSIN):
		previousButton.hide();
	changeClassSelection()


func changeClassSelection() -> void:
	var file = FileAccess.open("res://game/assets/data/classes.json", FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	
	var className: String = ""
	var classDesc: String = ""
	match classSelected:
		ClassCharacter.Classes.ASSASSIN:
			classDesc = result["assassin"]["description"]
			className = "Assassin"
		ClassCharacter.Classes.BARBARIAN:
			classDesc = result["barbarian"]["description"]
			className = "Barbarian"
		ClassCharacter.Classes.BATTLEMAGE:
			classDesc = result["battlemage"]["description"]
			className = "Battlemage"
		ClassCharacter.Classes.KNIGHT:
			classDesc = result["knight"]["description"]
			className = "Knight"
		ClassCharacter.Classes.NIGHTBLADE:
			classDesc = result["nightblade"]["description"]
			className = "Nightblade"
		ClassCharacter.Classes.ROGUE:
			classDesc = result["rogue"]["description"]
			className = "Rogue"
		ClassCharacter.Classes.SORCERER:
			classDesc = result["sorcerer"]["description"]
			className = "Sorcerer"
		ClassCharacter.Classes.SPELLSWORD:
			classDesc = result["spellsword"]["description"]
			className = "Spellsword"
		ClassCharacter.Classes.THIEF:
			classDesc = result["thief"]["description"]
			className = "Thief"
		_:
			print("Unexpected class given")
			return
	classNameLabel.text = className
	classDescLabel.text = classDesc
	
