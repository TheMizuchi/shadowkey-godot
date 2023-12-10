extends Node

# TODO: convert into "attribute system" that handles multiple stats

signal health_depleted
signal health_changed(new_value)

var parent_node
var max_health
var current_health
#var variable_in_parent

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

func get_current_health():
	return current_health

func get_max_health():
	return max_health

func set_max_health(value):
	max_health = value

func set_health(value):
	#if variable_in_parent:
		#get_parent().current_health = value
	#else:
	current_health = value
	health_changed.emit(value)

# TODO: remember what was the point of this
func inrease_health_by(value):
	health_changed.emit(value)
	current_health += value

func reduce_health(value):
	current_health -= value
	health_changed.emit(current_health)
	check_health_limit()

func increase_health(value):
	if value > 0:
		if current_health + value > max_health:
			current_health = int(max_health)
		else:
			current_health += value
	health_changed.emit(value)
	check_health_limit()

func check_health_limit():
	if current_health <= 0:
		emit_signal("health_depleted")
