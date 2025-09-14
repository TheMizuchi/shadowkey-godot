const PlayerStats = preload("res://game/actors/characters/player/player_stats.gd")

enum Races {ARGONIAN, BRETON, DARKELF, HIGHELF, KHAJIIT, NORD, REDGUARD, WOODELF}
enum Gender {MALE, FEMALE}

var charRace: Races
var gender: Gender
var bonusAttributes: Dictionary = {PlayerStats.CharAttributes.AGILITY:0,
                                   PlayerStats.CharAttributes.ENDURANCE:0,
                                   PlayerStats.CharAttributes.INTELLIGENCE:0,
                                   PlayerStats.CharAttributes.LUCK:0,
                                   PlayerStats.CharAttributes.PERSONALITY:0,
                                   PlayerStats.CharAttributes.SPEED:0,
                                   PlayerStats.CharAttributes.STRENGTH:0,
                                   PlayerStats.CharAttributes.WILLPOWER:0}
var defenceBonus: int
var attackBonus: int
var spellBonus: int
var magicRes: int
var ability: String

func _init(givenRace: Races, givenGender: Gender):
    match givenRace:
        Races.ARGONIAN:
            charRace = givenRace
            gender = givenGender
            ability = "Merchant Sense" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:10,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:10}
                defenceBonus = 2
                attackBonus = 0
                spellBonus = 20   
                magicRes = 2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:0}
                defenceBonus = 0
                attackBonus = 0
                spellBonus = 0   
                magicRes = 0      
        Races.BRETON:
            charRace = givenRace
            gender = givenGender
            ability = "Hardiness" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:-10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:-10,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:10}
                defenceBonus = -2
                attackBonus = 0
                spellBonus = 20   
                magicRes = 2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:-10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:10}
                defenceBonus = -2
                attackBonus = -20
                spellBonus = 20   
                magicRes = 2   
        Races.DARKELF:
            charRace = givenRace
            gender = givenGender
            ability = "Shadowed Path" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:0,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:10,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 0
                attackBonus = 0
                spellBonus = -20   
                magicRes = -2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:10,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 0
                attackBonus = 0
                spellBonus = -20   
                magicRes = -2
        Races.HIGHELF:
            charRace = givenRace
            gender = givenGender
            ability = "Mystic Blood" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:0,
                                PlayerStats.CharAttributes.INTELLIGENCE:10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:10,
                                PlayerStats.CharAttributes.SPEED:-10,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:0}
                defenceBonus = 0
                attackBonus = -20
                spellBonus = 0   
                magicRes = 0
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:0,
                                PlayerStats.CharAttributes.INTELLIGENCE:10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:10,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:0}
                defenceBonus = 0
                attackBonus = -20
                spellBonus = 0   
                magicRes = 0
        Races.KHAJIIT:
            charRace = givenRace
            gender = givenGender
            ability = "Cat Quick" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 2
                attackBonus = 0
                spellBonus = -20   
                magicRes = -2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:10,
                                PlayerStats.CharAttributes.ENDURANCE:0,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 2
                attackBonus = -20
                spellBonus = -20   
                magicRes = -2
        Races.NORD:
            charRace = givenRace
            gender = givenGender
            ability = "Nord Resilience" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:-10,
                                PlayerStats.CharAttributes.ENDURANCE:10,
                                PlayerStats.CharAttributes.INTELLIGENCE:-10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:10,
                                PlayerStats.CharAttributes.WILLPOWER:0}
                defenceBonus = -2
                attackBonus = 20
                spellBonus = 0   
                magicRes = 0
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:-10,
                                PlayerStats.CharAttributes.ENDURANCE:0,
                                PlayerStats.CharAttributes.INTELLIGENCE:-10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:10,
                                PlayerStats.CharAttributes.WILLPOWER:10}
                defenceBonus = -2
                attackBonus = 20
                spellBonus = 20   
                magicRes = 2
        Races.REDGUARD:
            charRace = givenRace
            gender = givenGender
            ability = "Ra' Gada Spirit" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:10,
                                PlayerStats.CharAttributes.INTELLIGENCE:-10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:-10,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:10,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 0
                attackBonus = 20
                spellBonus = -20   
                magicRes = -2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:0,
                                PlayerStats.CharAttributes.ENDURANCE:10,
                                PlayerStats.CharAttributes.INTELLIGENCE:-10,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:0,
                                PlayerStats.CharAttributes.STRENGTH:0,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 0
                attackBonus = 0
                spellBonus = -20   
                magicRes = -2
        Races.WOODELF:
            charRace = givenRace
            gender = givenGender
            ability = "Nature's Grace" 
            if gender == Gender.MALE:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:10,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 2
                attackBonus = -20
                spellBonus = -20   
                magicRes = -2
            else:
                bonusAttributes = {PlayerStats.CharAttributes.AGILITY:10,
                                PlayerStats.CharAttributes.ENDURANCE:-10,
                                PlayerStats.CharAttributes.INTELLIGENCE:0,
                                PlayerStats.CharAttributes.LUCK:0,
                                PlayerStats.CharAttributes.PERSONALITY:0,
                                PlayerStats.CharAttributes.SPEED:10,
                                PlayerStats.CharAttributes.STRENGTH:-10,
                                PlayerStats.CharAttributes.WILLPOWER:-10}
                defenceBonus = 2
                attackBonus = -20
                spellBonus = -20   
                magicRes = -2
        _:
            print("Unexpected Race given")
