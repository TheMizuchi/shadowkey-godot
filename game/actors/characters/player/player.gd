extends CharacterBody3D

# TODO: "health system" should be renamed and redesigned to be more abstract
# something like "player stats"

var character_class

@export var max_health = 100
var magic = 100
var fatigue = 100

var health_regen = 5
var magic_regen = 5
var fatigue_regen = 5
var regen_timer = Timer.new()

var equipment_types
enum attack_types {MELEE, PROJECTILE, SPELL}
enum projectile_types {ARROW, KNIFE, SPELL}
var weapon_list
var spell_list

var current_equip
var equipped_list
var inventory

# Equiped armors
var equipped_chest
var equipped_helm
var equipped_arms
var equipped_legs
var equipped_hands
var equipped_boots
var equipped_shield

var experience = 0

func _ready():
	#add_to_group("characters")
	$attack.set_aim_ray( $first_person_camera/aim_ray )
	$attack.set_projectile_anchor( $first_person_camera/projectile_anchor )
	#$shoot.set_projectile_scene( preload("res://game/actors/projectile/spell.tscn") )
	equipment_types = %item_list.types
	weapon_list = %item_list.weapons
	spell_list = %item_list.spells
	inventory = get_node("inventory")
	equipped_list = []
	#current_equip = null
	inventory.equip.connect(_on_equip_item)
	inventory.unequip.connect(_on_unequip_item)
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
	if current_equip.type in [equipment_types.Axe, equipment_types.Blunt, \
	equipment_types.Club, equipment_types.Longblade, equipment_types.Shortblade]:
		if meets_requirements_for(attack_types.MELEE):
			attack_melee()
			return true
	elif current_equip.type in [equipment_types.LightBow, equipment_types.MediumBow]:
		if meets_requirements_for(attack_types.PROJECTILE):
			shoot_projectile(projectile_types.ARROW)
			return true
	elif current_equip.type in [equipment_types.Thrown]:
		if meets_requirements_for(attack_types.PROJECTILE):
			shoot_projectile(projectile_types.KNIFE)
			return true
	# spellcheck lol
	# TODO: lolwat, no, self, area and and projectile need a different logic
	# will be handled when implementing magic effects I guess
	elif current_equip.type in [equipment_types.Self, equipment_types.Target, equipment_types.Area]:
		if meets_requirements_for(attack_types.SPELL):
			shoot_projectile(projectile_types.SPELL)
			return true
	return false

func attack_melee():
	$attack.shoot_hitscan()
	reduce_fatigue(20)

#handle arrow, throwing knife, fireball
func shoot_projectile(projectile_type, projectile_damage=10):
	$attack.shoot_projectile(projectile_damage)
	if projectile_type == projectile_types.ARROW:
		reduce_fatigue(5)
	elif projectile_type == projectile_types.KNIFE:
		reduce_fatigue(10)
	else:
		magic -= 10

func enable_control():
	$mouselook.enable()

func disable_control():
	$mouselook.disable()

# TODO: would "equip_type_category" be a better variable name for "rough_equip_type"?
func meets_requirements_for(rough_equip_type):
	if rough_equip_type == attack_types.SPELL:
		if magic < 10:
			return false
	# apparently attacking in Shadowkey can be done with fatigue at 0
	# TODO: implement toggle for this in the game options
	#elif rough_equip_type == attack_types.MELEE || rough_equip_type == attack_types.PROJECTILE:
		#if(fatigue < 15):
			#return false
	return true

func regenerate_stats():
	if $health_system.current_health < max_health:
		$health_system.increase_health(health_regen)
	if magic <= 100-magic_regen:
		magic += magic_regen
	if fatigue <= 100-fatigue_regen:
		fatigue += fatigue_regen

func jump():
	if fatigue >= 10:
		if $jump.jump():
			reduce_fatigue(10)

func reduce_fatigue(amount):
	if fatigue >= amount:
		fatigue -= amount
	else:
		fatigue = 0

func set_current_equip(item):
	current_equip = item
	$"../../../interface/hud/weapon_view".set_weapon(item)
	if(current_equip.type in [equipment_types.LightBow, equipment_types.MediumBow, equipment_types.Thrown, equipment_types.Target]):
		var projectile_scene
		if current_equip.type in [equipment_types.LightBow, equipment_types.MediumBow]:
			projectile_scene = preload("res://game/actors/projectile/arrow.tscn")
		elif current_equip.type in [equipment_types.Thrown]:
			projectile_scene = preload("res://game/actors/projectile/throwing_knife.tscn")
		elif current_equip.type in [equipment_types.Target]:
			projectile_scene = preload("res://game/actors/projectile/spell.tscn")
		$attack.set_projectile_scene(projectile_scene)

func activate_object():
	if not $info_area.object_queue.is_empty() and $info_area.object_queue[0]:
		$info_area.object_queue[0].activate()
		return $info_area.object_queue[0]

func _on_equip_item(item):
	if("armor_value" in item):
		match item.slot:
			equipment_types.Chest:
				equipped_chest = item
			equipment_types.Head:
				equipped_helm = item
			equipment_types.Arm:
				equipped_arms = item
			equipment_types.Leg:
				equipped_legs = item
			equipment_types.Hand:
				equipped_hands = item
			equipment_types.Boots:
				equipped_boots = item
			equipment_types.Shield:
				equipped_shield = item
	else:
		equipped_list.append(item)
		inventory.equipped_list = equipped_list
		if not current_equip:
			set_current_equip(item)

func _on_unequip_item(item):
	if("armor_value" in item):
		match item.slot:
			equipment_types.Chest:
				equipped_chest = null
			equipment_types.Head:
				equipped_helm = null
			equipment_types.Arm:
				equipped_arms = null
			equipment_types.Leg:
				equipped_legs = null
			equipment_types.Hand:
				equipped_hands = null
			equipment_types.Boots:
				equipped_boots = null
			equipment_types.Shield:
				equipped_shield = null
	else:
		equipped_list.erase(item)
		inventory.equipped_list = equipped_list
		if(current_equip == item and equipped_list.is_empty()):
			set_current_equip(null)
		elif(current_equip == item):
			set_current_equip(equipped_list.front())

func get_experience(amount):
	experience += amount
	# TODO: check for level increase
	
func _on_wake_up_area_body_entered(body):
	if body.is_in_group("opponents"):
		body.wake_up()

func _take_fall_damage(vertical_velocity):
	if vertical_velocity > 10:
		take_damage(vertical_velocity*2)

func has_armor_equipped(item):
	match item.slot:
		equipment_types.Chest:
			return equipped_chest == item
		equipment_types.Head:
			return equipped_helm == item
		equipment_types.Arm:
			return equipped_arms == item
		equipment_types.Leg:
			return equipped_legs == item
		equipment_types.Hand:
			return equipped_hands == item
		equipment_types.Boots:
			return equipped_boots == item
		equipment_types.Shield:
			return equipped_shield == item

func reward_quest(xp, reward):
	# make adding the reward & xp (when xp is here)
	if(reward != null):
		for key in reward.keys():
			print(reward.get(key))
	print(xp)
