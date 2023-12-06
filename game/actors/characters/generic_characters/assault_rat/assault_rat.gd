extends CharacterBody3D

@export var max_health = 30

func wake_up():
	$is_opponent.wake_up()

func take_damage(amount):
	$health_system.reduce_health(amount)
	$is_opponent.paint_red()
	#$is_opponent.draw_hit_sprite()
	if not $is_opponent.awake:
		wake_up()
		
func _on_health_system_health_depleted():
	# TODO: stop logic, then play dead animation, then queue_free
	var quest = get_node("quest_trigger")
	if quest:
		quest.progress_related_quests()
	$AnimationPlayer.play("ded")
