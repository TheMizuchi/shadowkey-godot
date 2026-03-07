extends Node2D

signal trade_open() ## TODO Add trading system with adding npc id for inventory

var response_functions = { }
var response_arguments = { }

@onready var dialoguesData: DialogueData = %dialogues_manager


func _ready():
	set_process(false)


func show_dialogue(newDialogue: DialogueData.Dialogue):
	var alltext: String = ""
	for line: int in newDialogue.lines:
		alltext = alltext + dialoguesData.textLines[line] + "\n"
	$contents/text.text = alltext

	# Removing all old responses
	for child in $contents/responses.get_children():
		child.queue_free()

	# Create new responses
	for i: int in newDialogue.responses.size():
		var newResponse: Button = Button.new()
		newResponse.text = dialoguesData.textLines[newDialogue.responses[i]]
		if (newDialogue.responsesActions[i] == null):
			newResponse.pressed.connect(close)
		elif (newDialogue.responsesActions[i] is int):
			newResponse.pressed.connect(show_dialogue.bind(dialoguesData.get_dialogue(newDialogue.responsesActions[i])))
		elif (newDialogue.responsesActions[i] == "TRADE"):
			newResponse.pressed.connect(trade_open.emit)
		elif (newDialogue.responsesActions[i] is String):
			newResponse.pressed.connect(sendProgressQuest.bind(newDialogue.responsesActions[i]))
		else:
			print("Wrong response actions")

		$contents/responses.add_child(newResponse)
	open()


func open():
	%logic.set_input_handler(&"menu")
	show()
	$very_short_timer.start()


func close():
	%logic.set_input_handler(&"fps")
	hide()


func sendProgressQuest(questId: String) -> void:
	%quest_tracking.progress_quest(questId)
	close()


func _on_very_short_timer_timeout():
	$contents/responses.get_children()[0].grab_focus()
