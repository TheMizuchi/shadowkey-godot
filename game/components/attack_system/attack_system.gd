extends Node

var raycast
var attack_node
var target_node

func _ready():
	raycast = get_parent().get_node("attack_ray")
	attack_node = get_parent().get_node("attack")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(attack_node.is_visible())
	if(target_node != null && raycast.get_collider() == target_node && attack_node.visible):
		_on_ray_entenred()

func _on_ray_entenred():
	get_parent().switch_animation(&"attack")
	print("something", target_node)
