extends Node2D

@export var button_group: ButtonGroup

const RaceCharacter = preload("res://game/actors/characters/player/races.gd")
signal name_empty(isEmpty:bool)

var raceSelected: RaceCharacter.Races = RaceCharacter.Races.ARGONIAN
var genderSelected: bool = false
var nameSelected: String = ""

func _ready() -> void:
    var buttons = button_group.get_buttons()
    buttons[0].connect("pressed", Callable(self, "change_gender").bind(false))
    buttons[1].connect("pressed", Callable(self, "change_gender").bind(true))

func _on_visibility_changed() -> void:
    raceSelected = get_parent().raceSelected
    var strRace = ""
    match raceSelected:
        RaceCharacter.Races.ARGONIAN:
            strRace = "Argonian"
        RaceCharacter.Races.BRETON:
            strRace = "Breton"
        RaceCharacter.Races.DARKELF:
            strRace = "DarkElf"
        RaceCharacter.Races.HIGHELF:
            strRace = "HighElf"
        RaceCharacter.Races.KHAJIIT:
            strRace = "Khajiit"
        RaceCharacter.Races.NORD:
            strRace = "Nord"
        RaceCharacter.Races.REDGUARD:
            strRace = "Redguard"
        RaceCharacter.Races.WOODELF:
            strRace = "WoodElf"
        _:
            print("Unexpected Race given")

    var buttons = button_group.get_buttons()
    buttons[0].icon = ResourceLoader.load("res://game/assets/ui_sprites/tmp/portraits/SK-icon-race-"+strRace+"M.png")
    buttons[1].icon = ResourceLoader.load("res://game/assets/ui_sprites/tmp/portraits/SK-icon-race-"+strRace+"F.png")
    name_empty.emit(true)
    


func change_gender(gender: bool) -> void:
    genderSelected = gender

func _on_name_edit_text_changed(nameEdited:String) -> void:
    if nameEdited == "":
        name_empty.emit(true)
    elif nameSelected == "":
        name_empty.emit(false)
    nameSelected = nameEdited
