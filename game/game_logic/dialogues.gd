class_name DialogueData
extends Node

# NOTE Dialogue data: https://obzorje.kompot.si/s/HcH3YArmRXgNL8z
#TODO Make it a data only script to load all the dialog and nothing else
# TODO: easter egg in Azra mountains should be Maiq the Liar, with appropriate
# dialog lines
enum ResultType { QUIT, ACCEPT, NEW_DIALOG }

const TEXT_LINES: String = "res://game/assets/data/text_lines_eng.json"
const DIALOGS_STRUCT: String = "res://game/assets/data/dialogs.json"

var textLines: Array[String] = []
var dialogues: Dictionary[int, Dialogue] = { }


#TODO singleton ?
func _ready():
	add_all_texts()
	add_all_dialogues()


func add_all_texts() -> void:
	var textsJson: Variant = readJsonFile(TEXT_LINES)
	for value in textsJson.values():
		textLines.append(str(value))


## Add all dialogs in the game through json files
func add_all_dialogues():
	# most dialogues should be all right. Report if any are messed up
	#var next = self.next_dialogue
	#var close = %dialogue_menu.close
	#var progress_quest = %quest_tracking.progress_quest

	## TODO for christ sake, do it elsewhere... Quest initialization must be elsewhere
	#add_dialogue(1362, [next, 1365], [close])
	#add_dialogue(1365, [next, 1366], [progress_quest, &"herbquest"])
	#add_dialogue(1366, [progress_quest, &"herbquest"])
	#add_dialogue(1589, [progress_quest, &"findthetemple"])
	#add_dialogue(1601, [], [])
	#add_dialogue(1600, [next, 1605])
	#add_dialogue(1605, [next, 1606])
	#add_dialogue(1606, [], [])

	var dialoguesJson: Variant = readJsonFile(DIALOGS_STRUCT)
	# generate placeholder values for dialogs that did not get added yet
	for key: String in dialoguesJson.keys():
		var value: Variant = dialoguesJson[key]
		dialogues[int(key)] = Dialogue.new(value["line_ids"], value["response_ids"], value["response_actions"])


## Show the dialog to the player at id
#TODO Give them either the text or the menu has the dialog object
func next_dialogue(id):
	%dialogue_menu.show_dialogue(id)


## Open the json file given and return the parse content as Variant
func readJsonFile(file_path: String) -> Variant:
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var result: Variant = JSON.parse_string(file.get_as_text())
	file.close()
	return result


## Class containing a dialog and it response
class Dialogue:
	## IDs for dialogue lines
	var lines: Array[int] = []
	## IDs for dialogue responses
	var responses: Array[int] = []
	## IDs for dialogue responses functions.
	## Must be either "TRADE", an other id dialogue,a quest name, or "".
	## Must be as long as reponses Array
	var responsesActions: Array = []


	# it is possible for 5 responses (snowline/llewydrconvo.s:26
	func _init(newLines: Array, newResponses: Array, newResponsesActions: Array) -> void:
		lines.append_array(newLines)
		responses.append_array(newResponses)
		# Sometimes int in json are read as float
		# TODO find why it's in float
		for action in newResponsesActions:
			if (action is float):
				action = int(action)
			responsesActions.append(action)
