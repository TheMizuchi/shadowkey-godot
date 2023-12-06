extends CharacterBody3D

@export var max_health = 30
var current_mesh
var current_animation_player
var animation_name

func _ready():
	current_mesh = $"rat_idle/frame0"
	current_animation_player = $"rat_idle/AnimationPlayer"
	switch_animation(&"idle")

func wake_up():
	$is_opponent.wake_up()
	switch_animation(&"walk")

func take_damage(amount):
	$health_system.reduce_health(amount)
	$is_opponent.paint_red()
	#$is_opponent.draw_hit_sprite()
	if not $is_opponent.awake:
		wake_up()

func switch_animation(state):
	#for mesh in [$mesh, $frame0, $frame0_001, $frame0_002, $frame0_003]:
		#mesh.hide()
	current_mesh.hide()
	current_animation_player.stop()
	match state:
		&"idle":
			current_mesh = $"rat_idle/frame0"
			current_animation_player = $rat_idle/AnimationPlayer
			animation_name = "KeyAction"
		&"walk":
			current_mesh = $"rat_walk/frame0"
			current_animation_player = $"rat_walk/AnimationPlayer"
			animation_name = "KeyAction"
		&"attack":
			current_mesh = $rat_attack/frame0_002
			current_animation_player = $rat_attack/AnimationPlayer
			animation_name = "Key_003Action"
		&"death":
			current_mesh = $"rat_death/frame0_003"
			current_animation_player = $rat_death/AnimationPlayer
			animation_name = "Key_004Action"
	current_mesh.show()
	current_animation_player.play(animation_name)

func _on_health_system_health_depleted():
	# TODO: stop logic, then play dead animation, then queue_free
	# TODO: properly check for quest trigger node, don't do it raw like this
	var quest
	for node in get_children():
		if node.name == &"quest_trigger":
			quest = get_node("quest_trigger")
	if quest:
		quest.progress_related_quests()
	#$AnimationPlayer.play("ded")
	switch_animation(&"death")
