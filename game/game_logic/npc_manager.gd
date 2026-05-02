class_name NpcManager
extends Node

const HasDialogue = preload("res://game/components/has_dialogue/has_dialogue.gd")
const NPC_START_DIALOGUES_FILE: String = "res://game/assets/data/npc_start_dialogues.json"

var npcDialogues: Dictionary[String, DialogueData.Dialogue] = { }
var npcTracked: Dictionary[String, HasDialogue] = { }


func _ready():
	var npcDialogueFile: Variant = readJsonFile(NPC_START_DIALOGUES_FILE)
	for npcId: String in npcDialogueFile.keys():
		npcDialogues[npcId] = %dialogues_manager.get_dialogue(npcDialogueFile[npcId])


## Open the json file given and return the parse content as Variant
func readJsonFile(file_path: String) -> Variant:
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var result: Variant = JSON.parse_string(file.get_as_text())
	file.close()
	return result


func addNpcTracked(npc: HasDialogue, npcId: String):
	npcTracked[npcId] = npc
	npc.set_dialogue(npcDialogues[npcId])


func updateNpcDialogue(npcId: String, dialogueId: int) -> void:
	var newDialogue: DialogueData.Dialogue = %dialogues_manager.get_dialogue(dialogueId)
	npcTracked[npcId].dialogue = newDialogue
	npcDialogues[npcId] = newDialogue
	print("Update ", npcId, " with dialogue ", dialogueId)


func updateNpcLocation(npcId: String, locationMarkerId: String) -> void:
	var locationMarkerArray: Array[Node] = get_tree().get_nodes_in_group("locator")
	var npcCharacterBody: CharacterBody3D = npcTracked[npcId].get_parent()
	for locationMarker: Node3D in locationMarkerArray:
		if (locationMarker.name == locationMarkerId):
			npcCharacterBody.global_position = locationMarker.global_position
