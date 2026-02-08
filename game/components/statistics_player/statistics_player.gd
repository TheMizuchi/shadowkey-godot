extends Node
class_name PlayerStats

const ItemListEnum = preload("res://game/game_logic/item_list.gd")

signal health_depleted

signal health_changed(new_value)
signal fatigue_changed(new_value)
signal magic_changed(new_value)

## Character attributes enumeration
enum Attributes {AGILITY,
				 ENDURANCE,
				 INTELLIGENCE,
				 LUCK,
				 PERSONALITY,
				 SPEED,
				 STRENGTH,
				 WILLPOWER}

## All races in game
enum Races {ARGONIAN,
			BRETON,
			DARKELF,
			HIGHELF,
			KHAJIIT,
			NORD,
			REDGUARD,
			WOODELF}

## All classes in game
enum Classes {ASSASSIN,
			  BARBARIAN,
			  BATTLEMAGE,
			  KNIGHT,
			  NIGHTBLADE,
			  ROGUE,
			  SORCERER,
			  SPELLSWORD,
			  THIEF}

## All types of classes in game
enum Guilds {FIGHTER,
			 MAGE,
			 THIEVES}


# Player choice for its character
var charRace: Races ## Which race is the character
var charClass: Classes ## Which class the character has
var charGuild: Guilds ## Which type of class
var gender: bool ## Gender of the player: false = male, true = female

# Allowed items and spells
var armorType: Array[ItemListEnum.ArmorCategories] = [] ## Armors type allowed for the class
var shieldType: Array[ItemListEnum.ArmorCategories] = [] ## Shield type allowed for the class
var weaponType: Array[ItemListEnum.ItemType] = [] ## Weapons type allowed for the class
var magicUser: bool ## Is the character can use magic

## Dictionary containing all character attributes (40 is the base stat)
var attributesDict: Dictionary[Attributes, int] = {Attributes.AGILITY:40,	
												   Attributes.ENDURANCE:40,
												   Attributes.INTELLIGENCE:40,
												   Attributes.LUCK:40,
												   Attributes.PERSONALITY:40,
												   Attributes.SPEED:40,
												   Attributes.STRENGTH:40,
												   Attributes.WILLPOWER:40}

# Stats calculated 
var defense: int ## Defense calculted by attributes 
var attack: int ## Attack calculted by attributes 
var spellDam: int ## Spell Damage calculted by attributes 
var magicRes: int ## Magic Res calculted by attributes 

# Gained abilities from race and class
var raceAbility: String ## Which ability the race add to the gameplay (NYI & TODO)
var classAbility: String ## Which ability the class add to the gameplay (NYI & TODO)

# Description
var raceDescription: String ## Description of the race selected
var classDescription: String ## Description of the class selected

func new_player_init(classSelected: Classes, raceSelected: Races, genderSelected: bool) -> void:
	get_races_stats(raceSelected, genderSelected)
	get_class_stats(classSelected)

## Add the change in the attribute indicated
func changeAttribute(attribute:Attributes, change:int):
	attributesDict[attribute] += change

## Update attributes with bonus attributes added by leveling up
func updateAttributes(toAddAttributes: Dictionary[Attributes, int]):
	for attr in toAddAttributes.keys():
		changeAttribute(attr, toAddAttributes[attr])

## Getting race stats from json file depending of the selected race and gender
func get_races_stats(givenRace: Races, givenGender: bool) -> void:
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
	attributesDict = {Attributes.AGILITY:raceAttributes[genderKey]["agility"],
					  Attributes.ENDURANCE:raceAttributes[genderKey]["endurance"],
					  Attributes.INTELLIGENCE:raceAttributes[genderKey]["intelligence"],
					  Attributes.LUCK:raceAttributes[genderKey]["luck"],
					  Attributes.PERSONALITY:raceAttributes[genderKey]["personality"],
					  Attributes.SPEED:raceAttributes[genderKey]["speed"],
					  Attributes.STRENGTH:raceAttributes[genderKey]["strength"],
					  Attributes.WILLPOWER:raceAttributes[genderKey]["willpower"]}
	defense=raceAttributes[genderKey]["defense"]
	attack=raceAttributes[genderKey]["attack"]
	spellDam=raceAttributes[genderKey]["spell"]
	magicRes=raceAttributes[genderKey]["magic"]
	raceAbility = raceAttributes["ability"]
	raceDescription = raceAttributes["description"]

## Getting class stats from json file depending of the selected class
func get_class_stats(givenClass: Classes) -> void:
	var file = FileAccess.open("res://game/assets/data/classes.json", FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	
	var classAttributes: Dictionary;
	match givenClass:
		Classes.ASSASSIN:
			classAttributes = result["assassin"]
		Classes.BARBARIAN:
			classAttributes = result["barbarian"]
		Classes.BATTLEMAGE:
			classAttributes = result["battlemage"]
		Classes.KNIGHT:
			classAttributes = result["knight"]
		Classes.NIGHTBLADE:
			classAttributes = result["nightblade"]
		Classes.ROGUE:
			classAttributes = result["rogue"]
		Classes.SORCERER:
			classAttributes = result["sorcerer"]
		Classes.SPELLSWORD:
			classAttributes = result["spellsword"]
		Classes.THIEF:
			classAttributes = result["thief"]
		_:
			print("Unexpected class given")
			return

	charClass = givenClass
	charGuild = _strToGuild(classAttributes["guild"])
	armorType = _dictToArmor(classAttributes["armor"])
	shieldType = _dictToArmor(classAttributes["shield"])
	weaponType = _dictToWeapon(classAttributes["weapon"])
	magicUser = classAttributes["magic"]
	classAbility = classAttributes["ability"]
	classDescription = classAttributes["description"]


## Conversion methods for getting races and classes stats
# TODO Find a better way to save those data

func _strToGuild(rawGuild: String) -> Guilds:
	if(rawGuild == "fighter"):
		return Guilds.FIGHTER
	elif(rawGuild == "mage"):
		return Guilds.MAGE
	elif(rawGuild == "thieves"):
		return Guilds.THIEVES
	else:
		return Guilds.FIGHTER

func _dictToArmor(rawArmors: Array) -> Array[ItemListEnum.ArmorCategories]:
	var armor: Array[ItemListEnum.ArmorCategories] = []
	for raw in rawArmors:
		if(raw == "light"):
			armor.append(ItemListEnum.ArmorCategories.LIGHT)
		elif(raw == "medium"):
			armor.append(ItemListEnum.ArmorCategories.MEDIUM)
		elif(raw == "heavy"):
			armor.append(ItemListEnum.ArmorCategories.HEAVY)
	return armor

func _dictToWeapon(rawWeapons: Array) -> Array[ItemListEnum.ItemType]:
	var weapon: Array[ItemListEnum.ItemType] = []
	for raw in rawWeapons:
		if(raw == "axe"):
			weapon.append(ItemListEnum.ItemType.AXE)
		elif(raw == "blunt"):
			weapon.append(ItemListEnum.ItemType.BLUNT)
		elif(raw == "club"):
			weapon.append(ItemListEnum.ItemType.CLUB)
		elif(raw == "lightbow"):
			weapon.append(ItemListEnum.ItemType.LIGHTBOW)
		elif(raw == "longblade"):
			weapon.append(ItemListEnum.ItemType.LONGBLADE)
		elif(raw == "mediumbow"):
			weapon.append(ItemListEnum.ItemType.MEDIUMBOW)
		elif(raw == "shorblade"):
			weapon.append(ItemListEnum.ItemType.SHORTBLADE)
		elif(raw == "thrown"):
			weapon.append(ItemListEnum.ItemType.THROWN)
	return weapon