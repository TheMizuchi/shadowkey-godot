extends Node

signal animation_finished

var item_list
var equipment_types
var current_weapon_type

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_types = %item_list.types
	
func set_weapon(weapon):
	if current_weapon_type:
		current_weapon_type.get_child(0).hide()
		current_weapon_type.get_child(1).stop()
		current_weapon_type.get_child(1).hide()
	match weapon.type:
		equipment_types.Axe:
			current_weapon_type = $axe
		equipment_types.Blunt:
			current_weapon_type = $mace
		equipment_types.Club:
			current_weapon_type = $club
		equipment_types.LightBow:
			current_weapon_type = $longbow
		equipment_types.Longblade:
			current_weapon_type = $sword
		equipment_types.MediumBow:
			current_weapon_type = $longbow
		equipment_types.Shortblade:
			current_weapon_type = $dagger
		equipment_types.Thrown:
			current_weapon_type = $thrown
		equipment_types.Self:
			current_weapon_type = $spell
		equipment_types.Target:
			current_weapon_type = $spell
		equipment_types.Area:
			current_weapon_type = $spell
	if weapon.name == &"Steel Crossbow" or weapon.name == &"Dwarven Crossbow":
		current_weapon_type = $crossbow
	current_weapon_type.get_child(0).show()

func play_animation():
	current_weapon_type.get_child(0).hide()
	current_weapon_type.get_child(1).show()
	current_weapon_type.get_child(1).play()

func is_animation_finished():
	if current_weapon_type:
		return not current_weapon_type.get_child(1).is_playing()

func _on_animation_finished():
	current_weapon_type.get_child(1).hide()
	current_weapon_type.get_child(0).show()
