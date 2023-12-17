extends CharacterBody3D

@export var max_health = 40
var current_mesh
var current_animation_player
var animation_name

func _ready():
	current_mesh = $"idle/frame0"
	current_animation_player = $"idle/AnimationPlayer"
	switch_animation(&"idle")

func wake_up():
	if $is_opponent.wake_up():
		switch_animation(&"walk")

func take_damage(amount):
	$health_system.reduce_health(amount)
	$paint_red.paint_red()
	if not $is_opponent.awake:
		wake_up()

func switch_animation(state):
	current_mesh.hide()
	current_animation_player.stop()
	var animation_node
	match state:
		&"idle":
			animation_node =$"idle"
		&"walk":
			animation_node =$"walk"
		&"attack":
			animation_node =$"attack"
		&"death":
			animation_node =$"death"
	current_mesh = animation_node.get_node("frame0")
	current_animation_player = animation_node.get_node("AnimationPlayer")
	current_mesh.show()
	current_animation_player.play(&"KeyAction")

func _on_health_system_health_depleted():
	# TODO: stop logic, then play dead animation, then queue_free
	# TODO: properly check for quest trigger node, don't do it raw like this
	var quest
	for node in get_children():
		if node.name == &"quest_trigger":
			quest = get_node("quest_trigger")
	if quest:
		quest.progress_related_quests()
	$CollisionShape3D.shape = null
	$movement_system.set_physics_process(false)
	switch_animation(&"death")
	$queue_free_timer.play("ded")
