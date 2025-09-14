extends Node

const ClassCharacter = preload("res://game/actors/characters/player/classes.gd")
const RaceCharacter = preload("res://game/actors/characters/player/races.gd")

@export var maxHealth: int = 100
@export var maxMagic: int = 100
@export var maxFatigue: int = 100
var currentHealth: int = maxHealth
var currentMagic: int = maxMagic
var currentFatigue: int = maxFatigue

var healthRegen: int = 5
var magicRegen: int = 5
var fatigueRegen: int = 5
var regenTimer: Timer = Timer.new() # one timer per stat?

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

func _init():
    setUpRegenTimer()
    currentClass = ClassCharacter.new(ClassCharacter.Classes.ASSASSIN)
    currentRace = RaceCharacter.new(RaceCharacter.Races.ARGONIAN, RaceCharacter.Gender.MALE)
    updateAttributes()

## Add the change in the health attribute
func changeHealth(health:int):
    currentHealth += health

## Add the change in the fatigue attribute
func changeFatigue(fatigue:int):
    currentFatigue += fatigue

## Add the change in the magic attribute
func changeMagicka(magic:int):
    currentMagic += magic

## Add the change in the attribute indicated
func changeAttribute(attribute:CharAttributes, change:int):
    attributesDict[attribute] += change

func updateAttributes():
    for attr in currentRace.bonusAttributes.keys():
        attributesDict[attr] += currentRace.bonusAttributes[attr]
        print(attributesDict[attr])

## Initiate the regen timer callback
func setUpRegenTimer():
    add_child(regenTimer)
    regenTimer.wait_time = 1
    regenTimer.start()
    regenTimer.timeout.connect(regenerateStats)

## Callback from timer to regen basic attributes (Rework)
func regenerateStats():
    # Health Regen
    if $health_system.currentHealth < maxHealth:
        $health_system.increase_health(healthRegen)
        changeHealth(healthRegen)
    # Magic Regen
    if currentMagic <= maxMagic-magicRegen:
        changeMagicka(magicRegen)
    # Fatigue Regen
    if currentFatigue <= maxFatigue-fatigueRegen:
        changeFatigue(fatigueRegen)
