extends Node

signal animation_finished

var current_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	current_weapon = $dagger

func set_weapon(weapon_name):
	current_weapon.get_child(0).hide()
	current_weapon.get_child(1).stop()
	current_weapon.get_child(1).hide()
	match weapon_name:
		"dagger":
			current_weapon = $dagger
		"spell":
			current_weapon = $spell
	current_weapon.get_child(0).show()

func play_animation():
	current_weapon.get_child(0).hide()
	current_weapon.get_child(1).show()
	current_weapon.get_child(1).play()

func _on_animation_finished():
	current_weapon.get_child(1).hide()
	current_weapon.get_child(0).show()
	emit_signal("animation_finished")
