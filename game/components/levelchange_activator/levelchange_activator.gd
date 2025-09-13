extends Node

#signal activated

@export var next_level = ""

var game_logic

# Called when the node enters the scene tree for the first time.
func _ready():
	game_logic = get_tree().root.get_node("game/logic")

func _on_body_entered(body):
	if body.is_in_group("player_character"):
		game_logic.change_level(next_level)
