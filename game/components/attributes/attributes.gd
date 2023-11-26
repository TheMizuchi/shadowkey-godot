extends Node

var attributes = {}
@export var default_starting_value = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	add_attribute(&"health")
	add_attribute(&"fatigue")
	add_attribute(&"magic")
	add_attribute(&"agililty")
	add_attribute(&"endurance")
	add_attribute(&"intelligence")
	add_attribute(&"luck")
	add_attribute(&"personality")
	add_attribute(&"speed")
	add_attribute(&"strength")
	add_attribute(&"willpower")
	add_attribute(&"armor")
	add_attribute(&"attack")
	add_attribute(&"damage")
	add_attribute(&"defense")
	add_attribute(&"magic resistance")

func add_attribute(name):
	attributes[name] = default_starting_value

func set_attribute_value(name, value):
	attributes[name] = value

func increase_attribute(name, value=1):
	attributes[name] += value
