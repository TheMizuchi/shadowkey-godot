extends 'res://game/actors/characters/generic_characters/opponent_template/opponent.gd'

func _ready() -> void:
	var projectile_scene = preload("res://game/actors/projectile/arrow.tscn")
	$shoot.set_projectile_scene(projectile_scene)
