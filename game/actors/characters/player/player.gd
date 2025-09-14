extends CharacterBody3D

const PlayerStats = preload("res://game/actors/characters/player/player_stats.gd")

# TODO: "health system" should be renamed and redesigned to be more abstract
# something like "player stats"

signal player_death

var playerStats = PlayerStats.new()

var equipment_types
enum attack_types {MELEE, PROJECTILE, SPELL}
enum projectile_types {ARROW, KNIFE, SPELL}
var weapon_list
var spell_list

var current_equip
var current_consumable
var equipped_list
var consumable_list
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
	equipment_types = %item_list.ItemType
	weapon_list = %item_list.weapons
	spell_list = %item_list.spells
	inventory = $inventory #get_node("inventory")
	equipped_list = []
	consumable_list = []
	#current_equip = null
	inventory.equip.connect(_on_equip_item)
	inventory.unequip.connect(_on_unequip_item)

func enable_control():
	$mouselook.enable()

func disable_control():
	$mouselook.disable()

func set_movement_vector(vector):
	$movement_system.movement_vector = vector

func take_damage(amount):
	$health_system.reduce_health(amount)

func use_equip():
	if not current_equip:
		return false
	if meets_requirements_for_using_current_equip():
		if current_equip.type in [equipment_types.AXE, equipment_types.BLUNT, \
		equipment_types.CLUB, equipment_types.LONGBLADE, equipment_types.SHORTBLADE]:
			attack_melee()
		elif current_equip.type in [equipment_types.LIGHTBOW, equipment_types.MEDIUMBOW]:
			shoot_projectile(projectile_types.ARROW)
		elif current_equip.type == equipment_types.Thrown:
			shoot_projectile(projectile_types.KNIFE)
		elif current_equip.type == equipment_types.Target:
			shoot_projectile(projectile_types.SPELL, 0, current_equip.id)
		elif current_equip.type in [equipment_types.SELF, equipment_types.AREA]:
			apply_spell_effect(current_equip.id)
		return true
	return false

func use_consumabe():
	pass

func attack_melee():
	$attack.shoot_hitscan()
	playerStats.changeFatigue(-20)

#handle arrow, throwing knife, fireball
func shoot_projectile(projectile_type, projectile_damage=10, spell=null):
	$attack.shoot_projectile(projectile_damage, spell)
	if projectile_type == projectile_types.ARROW:
		playerStats.changeFatigue(-5)
	elif projectile_type == projectile_types.KNIFE:
		playerStats.changeFatigue(-10)
	else:
		playerStats.changeMagicka(-current_equip.required_magic)



# TODO: deprecate this
# TODO: would "equip_type_category" be a better variable name for "rough_equip_type"?
func meets_requirements_for(action):  #rough_equip_type):
	# assume spellname
	if action is StringName:
		pass
	if action == attack_types.SPELL:
		if playerStats.magic < 10:
			return false
	# assume enum (one of attack_types)
	#else:
	# apparently attacking in Shadowkey can be done with fatigue at 0
	# TODO: implement toggle for this in the game options
	#elif rough_equip_type == attack_types.MELEE || rough_equip_type == attack_types.PROJECTILE:
		#if(fatigue < 15):
			#return false
	return true

func meets_requirements_for_using_current_equip():
	# check magic
	if current_equip.type in [equipment_types.SELF, equipment_types.TARGET, equipment_types.AREA]:
		if playerStats.currentMagic < current_equip.required_magic:
			return false
	return true

func jump():
	if playerStats.currentFatigue >= 10:
		if $jump.jump():
			playerStats.changeFatigue(10)

func set_current_equip(item):
	current_equip = item
	# TODO: lol this node path is bad spaghetti, figure out better way
	$"../../../interface/hud/weapon_view".set_weapon(item)
	if(current_equip.type in [equipment_types.LIGHTBOW, equipment_types.MEDIUMBOW, equipment_types.THROWN, equipment_types.TARGET]):
		var projectile_scene
		if current_equip.type in [equipment_types.LIGHTBOW, equipment_types.MEDIUMBOW]:
			projectile_scene = preload("res://game/actors/projectile/arrow.tscn")
		elif current_equip.type in [equipment_types.THROWN]:
			projectile_scene = preload("res://game/actors/projectile/throwing_knife.tscn")
		elif current_equip.type in [equipment_types.TARGET]:
			projectile_scene = preload("res://game/actors/projectile/spell.tscn")
		$attack.set_projectile_scene(projectile_scene)

func activate_object():
	if not $info_area.object_queue.is_empty() and $info_area.object_queue[0]:
		$info_area.object_queue[0].activate()
		return $info_area.object_queue[0]

func _on_equip_item(item):
	if("armor_value" in item):
		match item.slot:
			equipment_types.CHEST:
				equipped_chest = item
			equipment_types.HEAD:
				equipped_helm = item
			equipment_types.ARM:
				equipped_arms = item
			equipment_types.LEG:
				equipped_legs = item
			equipment_types.HAND:
				equipped_hands = item
			equipment_types.BOOTS:
				equipped_boots = item
			equipment_types.SHIELD:
				equipped_shield = item
	else:
		equipped_list.append(item)
		inventory.equipped_list = equipped_list
		if not current_equip:
			set_current_equip(item)

func _on_unequip_item(item):
	if("armor_value" in item):
		match item.slot:
			equipment_types.CHEST:
				equipped_chest = null
			equipment_types.HEAD:
				equipped_helm = null
			equipment_types.ARM:
				equipped_arms = null
			equipment_types.LEG:
				equipped_legs = null
			equipment_types.HAND:
				equipped_hands = null
			equipment_types.BOOTS:
				equipped_boots = null
			equipment_types.SHIELD:
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
		equipment_types.CHEST:
			return equipped_chest == item
		equipment_types.HEAD:
			return equipped_helm == item
		equipment_types.ARM:
			return equipped_arms == item
		equipment_types.LEG:
			return equipped_legs == item
		equipment_types.HAND:
			return equipped_hands == item
		equipment_types.BOOTS:
			return equipped_boots == item
		equipment_types.SHIELD:
			return equipped_shield == item

func apply_spell_effect(spell):
	if spell == &"healwound":
		$health_system.increase_health(30)
	playerStats.changeMagicka(-current_equip.required_magic)

func reward_quest(xp, reward):
	# make adding the reward & xp (when xp is here)
	if(reward != null):
		for key in reward.keys():
			print(reward.get(key))
	print(xp)

# TODO: most of this should probably be handled by game logic and not by player
func _on_health_system_health_depleted() -> void:
	disable_control()
	player_death.emit()
	
