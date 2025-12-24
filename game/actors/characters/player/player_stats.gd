class_name PlayerStats

signal health_depleted

signal health_changed(new_value)
signal fatigue_changed(new_value)
signal magic_changed(new_value)

## Character attributes enumeration
enum CharAttributes {AGILITY,
					 ENDURANCE,
					 INTELLIGENCE,
					 LUCK,
					 PERSONALITY,
					 SPEED,
					 STRENGTH,
					 WILLPOWER}

## Dictionary containing all character attributes
var attributesDict: Dictionary = {CharAttributes.AGILITY:40,
								  CharAttributes.ENDURANCE:40,
								  CharAttributes.INTELLIGENCE:40,
								  CharAttributes.LUCK:40,
								  CharAttributes.PERSONALITY:40,
								  CharAttributes.SPEED:40,
								  CharAttributes.STRENGTH:40,
								  CharAttributes.WILLPOWER:40}

var currentClass: ClassCharacter ## Character Class
var currentRace: RaceCharacter ## Character Race

func _init(classSelected: ClassCharacter.Classes, raceSelected: RaceCharacter.Races, genderSelected: bool) -> void:
	currentClass = ClassCharacter.new(classSelected)
	currentRace = RaceCharacter.new(raceSelected, genderSelected)
	updateAttributes()

## Add the change in the attribute indicated
func changeAttribute(attribute:CharAttributes, change:int):
	attributesDict[attribute] += change

func updateAttributes():
	for attr in currentRace.bonusAttributes.keys():
		attributesDict[attr] += currentRace.bonusAttributes[attr]
		print(attributesDict[attr])
