extends Node2D

var player
var health_bar
var magic_bar
var fatigue_bar

var refresh_timer = Timer.new()
var player_health_system

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player_character")[0]
	health_bar = $health_bar
	magic_bar = $magic_bar
	fatigue_bar = $fatigue_bar

	add_child(refresh_timer)
	refresh_timer.wait_time = 0.5
	refresh_timer.start()
	refresh_timer.timeout.connect(_update_time)

	player_health_system = player.get_node("health_system")
	player_health_system.health_changed.connect(_update_time)

func update_stats():
	set_health_bar_to(player_health_system.current_health)
	set_magic_bar_to(player_health_system.current_magic)
	set_fatigue_bar_to(player_health_system.current_fatigue)


func set_health_bar_to(value):
	health_bar.value = value

func set_magic_bar_to(value):
	magic_bar.value = value

func set_fatigue_bar_to(value):
	fatigue_bar.value = value

func _update_time():
	update_stats()
