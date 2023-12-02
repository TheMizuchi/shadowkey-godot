extends CharacterBody3D

# TODO: "health system" should be renamed and redesigned to be more abstract
# something like "player stats"

var character_class

@export var max_health = 100
var current_health = 100
var magic = 100
var fatigue = 100

var health_regen = 5
var magic_regen = 5
var fatigue_regen = 5

var equipment_types
enum attack_types {MELEE, PROJECTILE, SPELL}
enum projectile_types {ARROW, KNIFE, SPELL}
var weapon_list
var spell_list
var current_equip
var equipped_list
var regen_timer = Timer.new()

func _ready():
	#add_to_group("characters")
	$shoot.set_aim_ray( $first_person_camera/aim_ray )
	$shoot.set_projectile_anchor( $first_person_camera/projectile_anchor )
	$shoot.set_projectile_scene( preload("res://game/actors/projectile/arrow.tscn") )
	equipment_types = %equipment_list.types
	weapon_list = %equipment_list.weapons
	spell_list = %equipment_list.spells
	#equipped_list = [ weapon_list[&"irondagger"], weapon_list[&"daedricclaymore"], \
	#weapon_list[&"steelcrossbow"], spell_list[&"blaze"], weapon_list[&"ironthrowingknife"] ]
	#current_equip = equipped_list[0]
	equipped_list = []
	current_equip = null
	set_up_regen_timer()

func set_movement_vector(vector):
	$movement_system.movement_vector = vector

func take_damage(amount):
	$health_system.reduce_health(amount)

func set_up_regen_timer():
	add_child(regen_timer)
	regen_timer.wait_time = 1
	regen_timer.start()
	regen_timer.timeout.connect(regenerate_stats)

func use_equip():
	if not current_equip:
		return false
	if current_equip[1] in [equipment_types.Axe, equipment_types.Blunt, \
	equipment_types.Club, equipment_types.Longblade, equipment_types.Shortblade]:
		if meets_requirements_for(attack_types.MELEE):
			attack_melee()
	elif current_equip[1] in [equipment_types.LightBow, equipment_types.MediumBow]:
		if meets_requirements_for(attack_types.PROJECTILE):
			shoot_projectile(projectile_types.ARROW)
	elif current_equip[1] in [equipment_types.Thrown]:
		if meets_requirements_for(attack_types.PROJECTILE):
			shoot_projectile(projectile_types.KNIFE)
	# spellcheck lol
	elif current_equip[1] in [equipment_types.Self, equipment_types.Target, equipment_types.Area]:
		if meets_requirements_for(attack_types.SPELL):
			shoot_projectile(projectile_types.SPELL)

func attack_melee():
	$shoot.shoot_hitscan()
	fatigue -= 20

#handle arrow, throwing knife, fireball
func shoot_projectile(projectile_type, projectile_damage=10):
	$shoot.shoot_projectile(projectile_damage)
	if projectile_type == projectile_types.ARROW:
		fatigue -= 5
	elif projectile_type == projectile_types.KNIFE:
		fatigue -= 10
	else:
		magic -= 10

func enable_control():
	$mouselook.enable()

func disable_control():
	$mouselook.disable()

# apparently attacking in Shadowkey can be done with fatigue at 0
func meets_requirements_for(rough_equip_type):
	if rough_equip_type == attack_types.SPELL:
		if magic < 10:
			return false
	return true

func regenerate_stats():
	if current_health < max_health:
		$health_system.increase_health(health_regen)
	if magic <= 100-magic_regen:
		magic += magic_regen
	if fatigue <= 100-fatigue_regen:
		fatigue += fatigue_regen

func jump():
	if fatigue >= 10:
		if $jump.jump():
			fatigue -= 10

func set_current_equip(item):
	current_equip = item
	$"../../../interface/hud/weapon_view".set_weapon(item)
	var projectile_scene
	if current_equip[1] in [equipment_types.LightBow, equipment_types.MediumBow]:
		projectile_scene = preload("res://game/actors/projectile/arrow.tscn")
	elif current_equip[1] in [equipment_types.Thrown]:
		projectile_scene = preload("res://game/actors/projectile/throwing_knife.tscn")
	elif current_equip[1] in [equipment_types.Target]:
		projectile_scene = preload("res://game/actors/projectile/spell.tscn")
	$shoot.set_projectile_scene(projectile_scene)

func activate_object():
	if not $info_area.object_queue.is_empty() and $info_area.object_queue[0]:
		$info_area.object_queue[0].activate()
		return $info_area.object_queue[0]

func add_item(item):
	# TODO: lol get gud at coding
	if not item:
		return
	$inventory.add_item(item)
	# TODO: rever this temporary change of adding all picked up items to equiplist
	if item.size() > 1:
		equipped_list.append(item)
	if not current_equip:
		# TODO: lol this is very bad
		if item.size() > 1:
			set_current_equip(item)

func _on_health_system_health_changed():
	pass
	#$first_person_camera/fps_hud/health_indicator/ProgressBar.value = $health_system.get_current_health()

func _on_wake_up_area_body_entered(body):
	if body.is_in_group("opponents"):
		body.wake_up()
