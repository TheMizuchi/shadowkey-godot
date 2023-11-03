extends Node2D

var health_bar
var magic_bar
var fatigue_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar = $health/health_bar
	magic_bar = $magic/magic_bar
	fatigue_bar = $fatigue/fatigue_bar

func set_health_bar_to(value):
	health_bar.value = value
	
func set_magic_bar_to(value):
	magic_bar.value = value
	
func set_fatigue_bar_to(value):
	fatigue_bar.value = value
