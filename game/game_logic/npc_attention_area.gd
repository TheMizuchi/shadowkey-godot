extends Area3D

var player
# TODO: don't look just once, regularly check for new position

func _ready():
	player = get_parent()

func make_character_look(body):
	#var angle = body.position.signed_angle_to(player.position, Vector3.UP)
	var dist_x = body.position.x - player.position.x
	var dist_z = body.position.z - player.position.z
	var angle = atan2(dist_x, dist_z)
	body.look_at_player(angle, false)

func check_again():
	var body_list = get_overlapping_bodies()
	var got_character = false
	for body in body_list:
		if body.is_in_group(&"character"):
			got_character = true
			make_character_look(body)
	if got_character:
		$check_again_timer.start()
	else:
		$check_again_timer.stop()

func _on_body_entered(body):
	if body.is_in_group(&"character"):
		make_character_look(body)
		$check_again_timer.start()

func _on_check_again_timeout():
	check_again()
