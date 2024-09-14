extends CharacterBody3D

@export var max_health = 30
@export var drops = {}
@export var ennemy_id = ""
var current_mesh
var current_animation_player
var animation_name
var aim_ray

signal death(ennemy_id)

func _ready():
	current_mesh = $"idle/frame0"
	current_animation_player = $"idle/AnimationPlayer"
	if get_node("aim_ray"):
		aim_ray = get_node("aim_ray")
	switch_animation(&"idle")
	for drop in drops.keys():
		var item = get_tree().get_first_node_in_group(&"item_list").get_item(drop)
		$drop_loot.add_to_loot_table(item, drops.get(drop))
	
	var qt = get_node("/root/game/logic/quest_tracking")
	connect("death", qt._on_opponent_death)

# TODO: think whether this should be handled with physics process or maybe
# a short timer
func _physics_process(delta: float) -> void:
	if aim_ray:
		var target = aim_ray.get_collider()
		if target and target.is_in_group(&"player_character"):
			if $attack_timer.is_stopped():
				$attack_timer.start()


func attack_player():
	$movement_system.stop_moving()
	await get_tree().create_timer(0.5).timeout
	switch_animation(&"attack")
	$attack_logic.shoot_hitscan()
	await get_tree().create_timer(1.0).timeout
	switch_animation(&"walk")
	$movement_system.resume_moving()

func wake_up():
	if $is_opponent.wake_up():
		switch_animation(&"walk")

func take_damage(amount):
	$health_system.reduce_health(amount)
	$paint_red.paint_red()
	#$is_opponent.draw_hit_sprite()
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
			quest = node
	if quest:
		quest.progress_related_quests()
	$CollisionShape3D.shape = null
	$movement_system.set_physics_process(false)
	switch_animation(&"death")
	$drop_loot.drop_loot()
	$queue_free_timer.play("ded")
	death.emit(ennemy_id)
