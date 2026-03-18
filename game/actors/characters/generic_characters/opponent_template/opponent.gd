class_name Opponent
extends CharacterBody3D

signal death(ennemy_id)

enum OpponentState { IDLE, APPROACH, PREPARE, ATTACK, DEATH }

const TIMER_PREPARE_ATTACK: float = 3.0
const DEFAULT_SPRITE_BLOOD_HEIGHT: float = 1.5

@export var max_health: int = 30
@export var drops: Dictionary[String, float] = { }
@export var ennemy_id: String = ""
@export var attack_distance: float = 3

var current_mesh: MeshInstance3D
var current_animation_player: AnimationPlayer
var aim_ray: RayCast3D
var player: Player
var awake: bool = false
var movement_vector: Vector2 = Vector2()
var attack_cooldown_timer: Timer = Timer.new()
var do_math: bool = true
var current_state: OpponentState
#var damage_indicator_timer = Timer.new()
#var red = preload("res://game/assets/red_material/red_material_3d.tres")
var hit_sprite: PackedScene = preload("res://game/misc/blood_sprite/blood_sprite.tscn")


func _ready():
	add_to_group(&"characters")
	player = get_tree().get_first_node_in_group(&"player_character")
	if $attack_logic:
		$attack_logic.set_aim_ray($aim_ray)
	if get_node("aim_ray"):
		aim_ray = get_node("aim_ray")
	for drop in drops.keys():
		var item: ItemsList.Item = get_tree().get_first_node_in_group(&"item_list").get_item(drop)
		$drop_loot.add_to_loot_table(item, drops.get(drop))
	var qt: QuestManager = get_node("/root/game/logic/quest_manager")
	connect("death", qt._on_opponent_death)
	current_mesh = $"idle/frame0"
	current_animation_player = $"idle/AnimationPlayer"
	set_state(OpponentState.IDLE)
	set_physics_process(false)
	set_process(false)


# TODO: think whether this should be handled with physics process or maybe
# a short timer
func _physics_process(_delta: float) -> void:
	if aim_ray and is_near_player() and current_state == OpponentState.APPROACH:
		set_state(OpponentState.PREPARE)


func set_state(new_state: OpponentState) -> void:
	#print("setting ", name, " state to ", new_state)
	# prevent state overrides after death
	if current_state == OpponentState.DEATH:
		return
	current_state = new_state
	match current_state:
		OpponentState.IDLE:
			$movement_system.stop_moving()
			switch_animation(&"idle")
		OpponentState.APPROACH:
			$movement_system.resume_moving()
			switch_animation(&"walk")
		OpponentState.PREPARE:
			$movement_system.stop_moving()
			switch_animation(&"none")
			if $attack_timer.is_stopped():
				$attack_timer.start()
		OpponentState.ATTACK:
			attack_player()
		OpponentState.DEATH:
			var quest: QuestTrigger
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


func attack_player() -> void:
	if is_near_player():
		switch_animation(&"attack")
		$attack_logic.shoot_hitscan()
		# TODO: properly time with end of animation
		await get_tree().create_timer(TIMER_PREPARE_ATTACK).timeout
		set_state(OpponentState.PREPARE)
	else:
		set_state(OpponentState.APPROACH)


func wake_up() -> void:
	set_process(true)
	set_physics_process(true)
	if not awake:
		$movement_system.target_node = player
		set_state(OpponentState.APPROACH)
		awake = true


func is_near_player() -> bool:
	if do_math:
		if Vector2(position.x, position.z).distance_to(
			\
			Vector2(player.position.x, player.position.z),
		) < attack_distance:
			return true
	else:
		var target: Object = aim_ray.get_collider()
		if target and target.is_in_group(&"player_character"):
			return true
	return false


func take_damage(amount: int) -> void:
	$health_system.change_health(-amount)
	$paint_red.paint_red()
	#$is_opponent.draw_hit_sprite()
	if not $is_opponent.awake:
		wake_up()


func apply_spell_effect(spell: StringName) -> void:
	#print("got ", spell)
	# TODO: would it be better to enumerate this?
	if spell == &"blaze":
		take_damage(10)
	if spell == &"doomhammer":
		take_damage(50)
	if not $is_opponent.awake:
		wake_up()


func switch_animation(state: StringName) -> void:
	if current_mesh:
		current_mesh.hide()
	if current_animation_player:
		current_animation_player.stop()
	var animation_node: Node3D
	match state:
		&"none":
			animation_node = $"idle"
		&"idle":
			animation_node = $"idle"
		&"walk":
			animation_node = $"walk"
		&"attack":
			animation_node = $"attack"
		&"death":
			animation_node = $"death"
	current_mesh = animation_node.get_node("frame0")
	current_animation_player = animation_node.get_node("AnimationPlayer")
	if current_mesh:
		current_mesh.show()
	if state != &"none" and current_animation_player:
		current_animation_player.play(&"KeyAction")


func set_movement_vector(vector: Vector3) -> void:
	$"../movement_system".movement_vector = vector


func draw_hit_sprite(height: float = DEFAULT_SPRITE_BLOOD_HEIGHT) -> void:
	var sprite: Node3D = hit_sprite.instantiate()
	var parent_position: Vector3 = get_parent().position
	sprite.position = parent_position + Vector3(0, height, 0)
	#get_parent().add_child(sprite)
	add_child(sprite)


func _on_attack_timer_timeout() -> void:
	set_state(OpponentState.ATTACK)


func _on_health_system_health_depleted() -> void:
	# TODO: stop logic, then play dead animation, then queue_free
	# TODO: properly check for quest trigger node, don't do it raw like this
	set_state(OpponentState.DEATH)
