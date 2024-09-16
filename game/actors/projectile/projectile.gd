extends CharacterBody3D

#TODO: does it make sense to combine arrow/knife and spell projectile logic?

var direction_vector
@export_enum("arrow", "knife", "spell") var type: String = "arrow"
var damage = 10
var spell_effect

func _physics_process(_delta):
	move()

func set_damage(new_value):
	damage = new_value

func set_spell_effect(spell):
	spell_effect = spell

func move():
	var hit = move_and_collide(direction_vector)
	if hit:
		var collider = hit.get_collider()
		if collider.is_in_group("opponents"):
			if type in [ &"arrow", &"knife"]:
				collider.take_damage(damage)
			else:
				collider.apply_spell_effect(spell_effect)
			#return collider
		queue_free()
