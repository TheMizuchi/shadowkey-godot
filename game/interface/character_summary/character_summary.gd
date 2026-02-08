class_name CharacterSummary
extends Node2D


func class_to_str(givenClass: PlayerStats.Classes) -> String:
	match givenClass:
		PlayerStats.Classes.ASSASSIN:
			return "Assassin"
		PlayerStats.Classes.BARBARIAN:
			return "Barbarian"
		PlayerStats.Classes.BATTLEMAGE:
			return "Battlemage"
		PlayerStats.Classes.KNIGHT:
			return "Knight"
		PlayerStats.Classes.NIGHTBLADE:
			return "Nightblade"
		PlayerStats.Classes.ROGUE:
			return "Rogue"
		PlayerStats.Classes.SORCERER:
			return "Sorcerer"
		PlayerStats.Classes.SPELLSWORD:
			return "Spellsword"
		PlayerStats.Classes.THIEF:
			return "Thief"
		_:
			print("Unexpected class given")
			## TODO Crash
			return ""


func race_to_str(givenRace: PlayerStats.Races) -> String:
	match givenRace:
		PlayerStats.Races.ARGONIAN:
			return "Argonian"
		PlayerStats.Races.BRETON:
			return "Breton"
		PlayerStats.Races.DARKELF:
			return "DarkElf"
		PlayerStats.Races.HIGHELF:
			return "HighElf"
		PlayerStats.Races.KHAJIIT:
			return "Khajiit"
		PlayerStats.Races.NORD:
			return "Nord"
		PlayerStats.Races.REDGUARD:
			return "Redguard"
		PlayerStats.Races.WOODELF:
			return "WoodElf"
		_:
			print("Unexpected race given")
			## TODO Crash
			return ""


func _on_visibility_changed() -> void:
	if (%player):
		find_child("Name").text = %player.namePlayer
		var stats: PlayerStats = %player.playerStats
		if stats != null:
			# Portrait Loading
			# Maybe Load once when player get stats ?
			var strRace: String = class_to_str(stats.charClass)
			var strClass: String = race_to_str(stats.charRace)

			var strGender: String = "Male" if !stats.currentRace.gender else "Female"
			find_child("Portrait").texture = ResourceLoader.load(
				"res://game/assets/ui_sprites/tmp/portraits/SK-icon-race-"
				+ strRace + strGender[0] + ".png",
			)

			# General Values Loading
			var generals: VBoxContainer = find_child("GeneralContainer")
			generals.find_child("Class").text = strClass
			generals.find_child("Race").text = strRace
			generals.find_child("Gender").text = strGender

			# Attributes Loading
			var values: VBoxContainer = find_child("ValueContainer")
			values.find_child("Strength").text = str(stats.attributesDict[PlayerStats.Attributes.STRENGTH]).pad_decimals(0)
			values.find_child("Willpower").text = str(stats.attributesDict[PlayerStats.Attributes.WILLPOWER]).pad_decimals(0)
			values.find_child("Speed").text = str(stats.attributesDict[PlayerStats.Attributes.SPEED]).pad_decimals(0)
			values.find_child("Personality").text = str(stats.attributesDict[PlayerStats.Attributes.PERSONALITY]).pad_decimals(0)
			values.find_child("Intelligence").text = str(stats.attributesDict[PlayerStats.Attributes.INTELLIGENCE]).pad_decimals(0)
			values.find_child("Agility").text = str(stats.attributesDict[PlayerStats.Attributes.AGILITY]).pad_decimals(0)
			values.find_child("Endurance").text = str(stats.attributesDict[PlayerStats.Attributes.ENDURANCE]).pad_decimals(0)
			values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.Attributes.LUCK]).pad_decimals(0)

			## TODO Calculate those values in player stats
			values.find_child("Defense").text = str(stats).pad_decimals(0)
			values.find_child("Attack").text = str(stats).pad_decimals(0)
			values.find_child("Armor").text = str(stats).pad_decimals(0)
			values.find_child("SpellToHit").text = str(stats).pad_decimals(0)
			values.find_child("MagicResist").text = str(stats).pad_decimals(0)

			## TODO leveling system
			# values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.CharAttributes.LUCK]).pad_decimals(0)
			# values.find_child("Luck").text = str(stats.attributesDict[PlayerStats.CharAttributes.LUCK]).pad_decimals(0)
