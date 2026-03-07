extends Node

@export var npcID: String = ""

var dialogue: DialogueData.Dialogue

@onready var dialogue_menu: Node2D = get_tree().get_first_node_in_group(&"dialogue_menu")
@onready var npcManager = get_tree().root.get_node("game/logic/npc_manager")


func _ready() -> void:
	if npcID != "":
		npcManager.addNpcTracked(self, npcID)


# When interact with npc, show the corresponding dialogs
func display_dialogue():
	if dialogue:
		dialogue_menu.show_dialogue(dialogue)


func set_dialogue(newDialogue: DialogueData.Dialogue) -> void:
	dialogue = newDialogue
