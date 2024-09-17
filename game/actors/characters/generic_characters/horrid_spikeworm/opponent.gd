extends CharacterBody3D

@export var max_health = 30
@export var drops = {}
@export var ennemy_id = ""
var current_mesh
var current_animation_player
var animation_name
var aim_ray

enum opponent_state {idle, approach, prepare, attack, death}
var current_state : opponent_state

signal death(ennemy_id)

func _ready():
	current_mesh = $"idle/frame0"
	current_animation_player = $"idle/AnimationPlayer"
	if $attack_logic:
		$attack_logic.set_aim_ray( $aim_ray )
	if get_node("aim_ray"):
		aim_ray = get_node("aim_ray")
	for drop in drops.keys():
		var item = get_tree().get_first_node_in_group(&"item_list").get_item(drop)
		$drop_loot.add_to_loot_table(item, drops.get(drop))
	var qt = get_node("/root/game/logic/quest_tracking")
	connect("death", qt._on_opponent_death)
	switch_animation(&"idle")
	set_state(opponent_state.idle)

# TODO: think whether this should be handled with physics process or maybe
# a short timer
func _physics_process(delta: float) -> void:
	if aim_ray and is_near_player() and current_state == opponent_state.approach:
		set_state(opponent_state.prepare)

func _on_attack_timer_timeout() -> void:
	set_state(opponent_state.attack)

func set_state(new_state):
	# prevent state overrides after death
	if current_state == opponent_state.death:
		return
	current_state = new_state
	match current_state:
		opponent_state.idle:
			$movement_system.stop_moving()
			switch_animation(&"idle")
		opponent_state.approach:
			$movement_system.resume_moving()
			switch_animation(&"walk")
		opponent_state.prepare:
			$movement_system.stop_moving()
			switch_animation(&"none")
			if $attack_timer.is_stopped():
				$attack_timer.start()
		opponent_state.attack:
			attack_player()
		opponent_state.death:
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

func attack_player():
	if is_near_player():
		switch_animation(&"attack")
		$attack_logic.shoot_hitscan()
		# TODO: properly time with end of animation
		await get_tree().create_timer(2.0).timeout
		set_state(opponent_state.prepare)
	else:
		set_state(opponent_state.approach)

func wake_up():
	if $is_opponent.wake_up():
		set_state(opponent_state.approach)

# TODO: do this with raycast, area3D or just math to calculate distance?
func is_near_player():
	var target = aim_ray.get_collider()
	if target and target.is_in_group(&"player_character"):
		return true
	return false

func take_damage(amount):
	$health_system.reduce_health(amount)
	$paint_red.paint_red()
	#$is_opponent.draw_hit_sprite()
	if not $is_opponent.awake:
		wake_up()

func apply_spell_effect(spell):
	#print("got ", spell)
	if spell == &"blaze":
		take_damage(10)
	if spell == &"doomhammer":
		take_damage(50)
	if not $is_opponent.awake:
		wake_up()

func switch_animation(state):
	current_mesh.hide()
	current_animation_player.stop()
	var animation_node
	match state:
		&"none":
			animation_node =$"idle"
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
	if state != &"none":
		current_animation_player.play(&"KeyAction")

func _on_health_system_health_depleted():
	# TODO: stop logic, then play dead animation, then queue_free
	# TODO: properly check for quest trigger node, don't do it raw like this	
	set_state(opponent_state.death)
