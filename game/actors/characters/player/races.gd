class_name RaceCharacter

enum Races {ARGONIAN, BRETON, DARKELF, HIGHELF, KHAJIIT, NORD, REDGUARD, WOODELF}

var charRace: Races
var gender: bool ## Gender of the player: false = male, true = female
var bonusAttributes: Dictionary = {PlayerStats.CharAttributes.AGILITY:0,
                                   PlayerStats.CharAttributes.ENDURANCE:0,
                                   PlayerStats.CharAttributes.INTELLIGENCE:0,
                                   PlayerStats.CharAttributes.LUCK:0,
                                   PlayerStats.CharAttributes.PERSONALITY:0,
                                   PlayerStats.CharAttributes.SPEED:0,
                                   PlayerStats.CharAttributes.STRENGTH:0,
                                   PlayerStats.CharAttributes.WILLPOWER:0}
var defenseBonus: int
var attackBonus: int
var spellBonus: int
var magicRes: int
var ability: String
var description: String

func _init(givenRace: Races, givenGender: bool):
    var file = FileAccess.open("res://game/assets/data/races.json", FileAccess.READ)
    var content = file.get_as_text()
    var result = JSON.parse_string(content)
    
    var raceAttributes: Dictionary;
    match givenRace:
        Races.ARGONIAN:
            raceAttributes = result["argonian"]
        Races.BRETON:
            raceAttributes = result["breton"]
        Races.DARKELF:
            raceAttributes = result["darkelf"]
        Races.HIGHELF:
            raceAttributes = result["highelf"]
        Races.KHAJIIT:
            raceAttributes = result["khajiit"]
        Races.NORD:
            raceAttributes = result["nord"]
        Races.REDGUARD:
            raceAttributes = result["redguard"]
        Races.WOODELF:
            raceAttributes = result["woodelf"]
        _:
            print("Unexpected class given")
            return

    charRace = givenRace
    gender = givenGender

    var genderKey = "male" if !gender else "female"
    bonusAttributes = {PlayerStats.CharAttributes.AGILITY:raceAttributes[genderKey]["agility"],
                        PlayerStats.CharAttributes.ENDURANCE:raceAttributes[genderKey]["endurance"],
                        PlayerStats.CharAttributes.INTELLIGENCE:raceAttributes[genderKey]["intelligence"],
                        PlayerStats.CharAttributes.LUCK:raceAttributes[genderKey]["luck"],
                        PlayerStats.CharAttributes.PERSONALITY:raceAttributes[genderKey]["personality"],
                        PlayerStats.CharAttributes.SPEED:raceAttributes[genderKey]["speed"],
                        PlayerStats.CharAttributes.STRENGTH:raceAttributes[genderKey]["strength"],
                        PlayerStats.CharAttributes.WILLPOWER:raceAttributes[genderKey]["willpower"]}
    defenseBonus=raceAttributes[genderKey]["defense"]
    attackBonus=raceAttributes[genderKey]["attack"]
    spellBonus=raceAttributes[genderKey]["spell"]
    magicRes=raceAttributes[genderKey]["magic"]
    ability = raceAttributes["ability"]
    description = raceAttributes["description"]
