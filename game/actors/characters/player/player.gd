extends CharacterBody3D

# TODO: "health system" should be renamed and redesigned to be more abstract
# something like "player stats"
@export var max_health = 100
var current_health = 100
var magic = 100
var fatigue = 100

var health_regen = 5
var magic_regen = 5
var fatigue_regen = 5

var equip_types
var weapon_list
var spell_list
var current_equip
var equipped_list #= ["dagger", "spell"]
var regen_timer = Timer.new()

func _ready():
	add_to_group("characters")
	$shoot.set_aim_ray( $first_person_camera/aim_ray )
	$shoot.set_projectile_anchor( $first_person_camera/projectile_anchor )
	$shoot.set_projectile_scene( preload("res://game/actors/projectile/projectile.tscn") )
	equip_types = $"../../../logic/equipment_list".types
	weapon_list = $"../../../logic/equipment_list".weapons
	spell_list = $"../../../logic/equipment_list".spells
	equipped_list = [ weapon_list["irondagger"], weapon_list["daedricclaymore"], \
	weapon_list["steelcrossbow"], spell_list["blaze"] ]
	add_child(regen_timer)
	regen_timer.wait_time = 1
	regen_timer.start()
	regen_timer.timeout.connect(regenerate_stats)
	current_equip = equipped_list[1]

func set_movement_vector(vector):
	$movement_system.movement_vector = vector

func take_damage(amount):
	$health_system.reduce_health(amount)

func use_equip():
	
	if current_equip[1] in [equip_types.Axe, equip_types.Blunt, \
	equip_types.Club, equip_types.Longblade, equip_types.Shortblade]:
		if meets_requirements_for("melee"):
			attack_melee()
	elif current_equip[1] in [equip_types.LightBow, equip_types.MediumBow]:
		if meets_requirements_for("projectile"):
			shoot_projectile("arrow")
	# spellcheck lol
	elif current_equip[1] in [equip_types.Self, equip_types.Target, equip_types.Area]:
		shoot_projectile("spell")

func attack_melee():
	$shoot.shoot_hitscan()
	fatigue -= 20

#handle arrow, throwing knife, fireball
func shoot_projectile(rough_projectile_type):
	$shoot.shoot_projectile()
	if rough_projectile_type in ["arrow", "throw"]:
		fatigue -= 10
	else:
		magic -= 10

func enable_control():
	$mouselook.enable()

func disable_control():
	$mouselook.disable()

func increase_ammo(value = 1):
	$inventory.increase_ammo(value)

func reduce_ammo(value = 1):
	$inventory.reduce_ammo(value)

func get_ammo_count():
	return $inventory.ammo

func meets_requirements_for(rough_equip_type):
	if rough_equip_type == "melee":
		if fatigue >= 20:
			return true
	if rough_equip_type == "projectile":
		if fatigue >= 10:
			return true
	if rough_equip_type == "spell":
		if magic >= 10:
			return true
	return false
		
func can_attack():
	if current_equip == "dagger":
		if fatigue >= 10:
			return true
	else:
		if magic >= 10:
			return true
	return false

func regenerate_stats():
	if current_health < max_health:
		$health_system.increase_health(health_regen)
	if magic <= 100-magic_regen:
		magic += magic_regen
	if fatigue <= 100-fatigue_regen:
		fatigue += fatigue_regen

func _on_health_system_health_changed():
	pass
	#$first_person_camera/fps_hud/health_indicator/ProgressBar.value = $health_system.get_current_health()

func _on_wake_up_area_body_entered(body):
	if body.is_in_group("opponents"):
		body.wake_up()

##TODO: use ENUM
#func pick_up_item(type, value):
	#if type == "ammo":
		#increase_ammo(value)
	#if type == "health":
		#pass
	#if type == "weapon":
		#pass
	##print(type, value)
