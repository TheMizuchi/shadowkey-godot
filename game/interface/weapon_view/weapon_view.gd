extends Node

#signal animation_finished

var item_list
var equipment_types
var current_weapon_type

# Called when the node enters the scene tree for the first time.
func _ready():
	equipment_types = %item_list.ItemType
	
func set_weapon(weapon):
	if current_weapon_type:
		current_weapon_type.get_child(0).hide()
		current_weapon_type.get_child(1).stop()
		current_weapon_type.get_child(1).hide()
	if not weapon:
		current_weapon_type.get_child(0).hide()
		current_weapon_type = null
		return
	match weapon.type:
		equipment_types.AXE:
			current_weapon_type = $axe
		equipment_types.BLUNT:
			current_weapon_type = $mace
		equipment_types.CLUB:
			current_weapon_type = $club
		equipment_types.LIGHTBOW:
			current_weapon_type = $longbow
		equipment_types.LONGBLADE:
			current_weapon_type = $sword
		equipment_types.MEDIUMBOW:
			current_weapon_type = $longbow
		equipment_types.SHORTBLADE:
			current_weapon_type = $dagger
		equipment_types.THROWN:
			current_weapon_type = $thrown
		equipment_types.SELF:
			current_weapon_type = $spell
		equipment_types.TARGET:
			current_weapon_type = $spell
		equipment_types.AREA:
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
