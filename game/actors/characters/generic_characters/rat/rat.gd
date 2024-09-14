extends 'res://game/actors/characters/generic_characters/opponent_template/opponent.gd'

func _ready() -> void:
	super._ready()
	$attack_logic.set_aim_ray( $aim_ray )

func _on_attack_timer_timeout() -> void:
	super.attack_player()
