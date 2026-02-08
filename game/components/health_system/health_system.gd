extends Node

# TODO: convert into "attribute system" that handles multiple stats
signal health_depleted
signal health_changed(new_value)
signal magic_changed(new_value)
signal fatigue_changed(new_value)

var parent_node
var max_health: int = 100
var max_magic: int = 100
var max_fatigue: int = 100
var current_health: int = max_health
var current_magic: int = max_magic
var current_fatigue: int = max_fatigue
#var variable_in_parent
var healthRegen: int = 5
var magicRegen: int = 5
var fatigueRegen: int = 5


func _ready():
	parent_node = get_parent()
	#if "current_health" in parent_node:
	#variable_in_parent = true
	get_owner_stats()


func get_owner_stats():
	if not parent_node.get("max_health") == null:
		max_health = parent_node.max_health
		current_health = float(max_health) # copy the value
	else: #TODO: implement proper fallback
		max_health = 100
		current_health = 100


func change_health(value):
	current_health += value
	if current_health > max_health:
		current_health = max_health
	health_changed.emit(value)
	check_health_limit()


func change_magic(value):
	current_magic += value
	if current_magic > max_magic:
		current_magic = max_magic
	magic_changed.emit(value)


func change_fatigue(value):
	current_fatigue += value
	if current_fatigue > max_fatigue:
		current_fatigue = max_fatigue
	fatigue_changed.emit(value)


func check_health_limit():
	if current_health <= 0:
		emit_signal("health_depleted")


# For the moment just use this here but put it in an health system dedicated to the player
## Callback from timer to regen basic attributes (Rework)
func regenerateStats():
	# Health Regen
	if current_health < max_health:
		#$health_system.increase_health(healthRegen)
		change_health(healthRegen)
	# Magic Regen
	if current_magic <= max_magic - magicRegen:
		change_magic(magicRegen)
	# Fatigue Regen
	if current_fatigue <= max_fatigue - fatigueRegen:
		change_fatigue(fatigueRegen)
