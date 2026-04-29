class_name QuestManager
extends Node

const QUESTS_FILE: String = "res://game/assets/data/quests.json"

# TODO: figure out quest stage matrix
# should quest stage dialogues start at 1?
# TODO: figure out how to handle cont tracking
# rats killed, refugees helped, etc
var quests: Dictionary[String, Quest] = { }

@onready var player = %player
@onready var dialogues: Dictionary[int, DialogueData.Dialogue] = %dialogues_manager.dialogues


func _ready():
	add_all_quests(readJsonFile(QUESTS_FILE))


# TODO put this function in a json tool script to call it whenever its needed
## Open the json file given and return the parse content as Dictionary
func readJsonFile(file_path: String) -> Dictionary:
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var result: Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	return result


func add_all_quests(rawQuests: Dictionary):
	for questId: String in rawQuests.keys():
		quests[questId] = Quest.new(rawQuests[questId], %npc_manager)
		quests[questId].connect(&"complete_quest", player.reward_quest)


func get_quest_stage(quest_name):
	return quests[quest_name].current_stage


func is_quest_completed(quest_name):
	return quests[quest_name].completed


## Set this stage as completed and look for the next stage
func set_quest_complete_stage(quest_name: String, stage: int):
	quests[quest_name].set_complete_stage(stage)


func progress_quest(quest_name):
	quests[quest_name].progress_quest()
	return true


func _on_opponent_death(ennemy_name: String):
	for quest_id in quests:
		var quest: Quest = quests.get(quest_id)
		quest.progress_mob_count(ennemy_name)


class Quest:
	var name: String = ""
	var xp: int = 0
	var gold: int = 0
	var stages: Dictionary[int, Stage] = { } # Array for this?
	var current_stage: Stage = null
	var completed: bool = false
	var started: bool = false

	#TODO add items reward, not enough quests to test with
	#TODO add when completed a stage without interacting with something (killing something for ex)

	signal complete_quest(xp: int, reward: Dictionary)


	func _init(rawQuest: Dictionary, npcManager: NpcManager) -> void:
		name = rawQuest["name"]
		xp = rawQuest["xp"]
		gold = rawQuest["gold"]
		for rawStage: Dictionary in rawQuest["stages"]:
			var stage: Stage = Stage.new(self, rawStage, npcManager)
			stages[stage.id] = stage


	func get_stage() -> Stage:
		return current_stage


	func set_complete_stage(stageId: int) -> void:
		if (current_stage == null or current_stage.id <= stageId):
			if (stageId >= stages.size() && !completed):
				stages[stages.size()].on_complete()
				completed = true
				started = true
				complete_quest.emit(xp, [])
				print(name, " completed")
			elif (stageId < stages.size()):
				started = true
				stages[stageId].on_complete()
				current_stage = stages[stageId + 1]
				current_stage.has_been_reached()
				print(name, " has set stage ", stageId, " as completed")
			else:
				# nothing to do
				pass


	func progress_quest() -> void:
		if (current_stage == null):
			started = true
			set_complete_stage(1)
		elif (current_stage.id < stages.size()):
			started = true
			set_complete_stage(current_stage.id)
		elif (current_stage.id == stages.size()):
			current_stage.on_complete()
			completed = true
			complete_quest.emit(xp, { })
			print(name, " completed")


	func progress_mob_count(ennemy_name: String) -> void:
		if (started && current_stage.nbEnnemies > 0):
			current_stage.progress_mob_count(ennemy_name)


## Class for the differents stages accross a quest (NEVER USE IT AS IT IS)
class Stage:
	var id: int = 0 ## ID of the stage
	var parentQuest: Quest ## Quest object linked to this stage
	var description: String = "" ## Description of the stage

	var action: Dictionary = { } ## The action needed to be done on the stage
	var npcManager: NpcManager ## The NPC manager to change dialogue and position of an npc
	var nbEnnemies: int = -1 ## The number of ennemies to kill, required for kill stages

	var actionComplete: Dictionary = { } ## The action done when completing the stage


	func _init(newParentQuest: Quest, rawStage: Dictionary, newNpcManager: NpcManager) -> void:
		parentQuest = newParentQuest
		id = int(rawStage["id"])
		description = rawStage["description"]
		npcManager = newNpcManager
		if ("objectives" in rawStage):
			action = rawStage["objectives"]
		if ("on_complete" in rawStage):
			actionComplete = rawStage["on_complete"]


	func progress_mob_count(ennemy_name: String) -> void:
		var idEnnemy: String = action["kill"].keys()[0]
		if (ennemy_name == idEnnemy):
			nbEnnemies -= 1
			if (nbEnnemies == 0):
				parentQuest.progress_quest()


	func has_been_reached() -> void:
		if action != { }:
			match (action.keys()[0]):
				"goto":
					var idEntity: String = action["goto"]
				"talk":
					var idNPC: String = action["talk"].keys()[0]
					var idDialogue: int = action["talk"][idNPC]
					npcManager.updateNpcDialogue(idNPC, idDialogue)
				"kill":
					nbEnnemies = action["kill"][action["kill"].keys()[0]]
				_:
					return


	func on_complete() -> void:
		if actionComplete != { }:
			match (actionComplete.keys()[0]):
				"move":
					var idNPC: String = actionComplete["move"].keys()[0]
					var idLocation: String = actionComplete["move"][idNPC]
					npcManager.updateNpcLocation(idNPC, idLocation)
				"talk":
					var idNPC: String = actionComplete["talk"].keys()[0]
					var idDialogue: int = actionComplete["talk"][idNPC]
					npcManager.updateNpcDialogue(idNPC, idDialogue)
				_:
					return
