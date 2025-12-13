extends Node2D

const PlayerStats = preload("res://game/actors/characters/player/player_stats.gd")
const ClassCharacter = preload("res://game/actors/characters/player/classes.gd")
const RaceCharacter = preload("res://game/actors/characters/player/races.gd")

func _on_visibility_changed() -> void:
	find_child("Name").text = %player.namePlayer

	var stats: PlayerStats = %player.playerStats
	if stats != null:
		# Portrait Loading
		# Maybe Load once when player get stats ?
		var strRace: String = ""
		match stats.currentRace.charRace:
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
		
		var strClass: String = ""
		match stats.currentClass.charClass:
			ClassCharacter.Classes.ASSASSIN:
				strClass = "Assassin"
			ClassCharacter.Classes.BARBARIAN:
				strClass = "Barbarian"
			ClassCharacter.Classes.BATTLEMAGE:
				strClass = "Battlemage"
			ClassCharacter.Classes.KNIGHT:
				strClass = "Knight"
			ClassCharacter.Classes.NIGHTBLADE:
				strClass = "Nightblade"
			ClassCharacter.Classes.ROGUE:
				strClass = "Rogue"
			ClassCharacter.Classes.SORCERER:
				strClass = "Sorcerer"
			ClassCharacter.Classes.SPELLSWORD:
				strClass = "Spellsword"
			ClassCharacter.Classes.THIEF:
				strClass = "Thief"
			_:
				print("Unexpected class given")
		var strGender: String = "Male" if !stats.currentRace.gender else "Female"
		find_child("Portrait").texture = ResourceLoader.load("res://game/assets/ui_sprites/tmp/portraits/SK-icon-race-"+strRace+strGender[0]+".png")

		# General Values Loading
		var generals = find_child("GeneralContainer")
		generals.find_child("Class").text = strClass
		generals.find_child("Race").text = strRace
		generals.find_child("Gender").text = strGender

		# Attributes Loading
		var values = find_child("ValueContainer")
		values.find_child("Strength").text = str(stats.attributesDict[PlayerStats.CharAttributes.STRENGTH]).pad_decimals(0)
		values.find_child("Willpower").text = str(stats.attributesDict[PlayerStats.CharAttributes.WILLPOWER]).pad_decimals(0)
		values.find_child("Speed").text = str(stats.attributesDict[PlayerStats.CharAttributes.SPEED]).pad_decimals(0)
		values.find_child("Personality").text = str(stats.attributesDict[PlayerStats.CharAttributes.PERSONALITY]).pad_decimals(0)
		values.find_child("Intelligence").text = str(stats.attributesDict[PlayerStats.CharAttributes.INTELLIGENCE]).pad_decimals(0)
		values.find_child("Agility").text = str(stats.attributesDict[PlayerStats.CharAttributes.AGILITY]).pad_decimals(0)
		values.find_child("Endurance").text = str(stats.attributesDict[PlayerStats.CharAttributes.ENDURANCE]).pad_decimals(0)
		values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.CharAttributes.LUCK]).pad_decimals(0)
		
		## TODO Calculate those values in player stats
		# values.find_child("Defense").text = str(stats).pad_decimals(0)
		# values.find_child("Attack").text = str(stats).pad_decimals(0)
		# values.find_child("Armor").text = str(stats).pad_decimals(0)
		# values.find_child("SpellToHit").text = str(stats).pad_decimals(0)
		# values.find_child("MagicResist").text = str(stats).pad_decimals(0)
		
		## TODO leveling system
		# values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.CharAttributes.LUCK]).pad_decimals(0)
		# values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.CharAttributes.LUCK]).pad_decimals(0)
