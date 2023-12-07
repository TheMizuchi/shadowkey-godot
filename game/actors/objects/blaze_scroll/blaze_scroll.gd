extends Node

var prompt = &"Learn Blaze"
var prompt2 = &"Pick up Blaze scroll"
var list
var player

func _ready():
	list = get_tree().get_first_node_in_group(&"item_list")
	player = get_tree().get_first_node_in_group(&"player_character")

func activate():
	# TODO: properly conver this to singleton
	var blaze = list.spells[&"blaze"]
	player.add_item(blaze)
	queue_free()
