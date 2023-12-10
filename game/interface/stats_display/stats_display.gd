extends Node2D

var player
var health_bar
var magic_bar
var fatigue_bar

var refresh_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player_character")[0]
	health_bar = $health/health_bar
	magic_bar = $magic/magic_bar
	fatigue_bar = $fatigue/fatigue_bar
	
	add_child(refresh_timer)
	refresh_timer.wait_time = 0.5
	refresh_timer.start()
	refresh_timer.timeout.connect(_update_time)
	
	var player_health_system = player.get_node("health_system")
	player_health_system.health_changed.connect(_update_time)

func update_stats():
	set_health_bar_to(player.get_node("health_system").current_health)
	set_magic_bar_to(player.magic)
	set_fatigue_bar_to(player.fatigue)
	

func set_health_bar_to(value):
	health_bar.value = value
	
func set_magic_bar_to(value):
	magic_bar.value = value
	
func set_fatigue_bar_to(value):
	fatigue_bar.value = value

func _update_time(new_health=null):
	update_stats()

# 
#func _physics_process(delta):
	#pass
