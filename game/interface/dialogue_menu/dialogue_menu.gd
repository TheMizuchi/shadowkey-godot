extends Node2D

var response_functions = {}
var response_arguments = {}

func _ready():
	set_process(false)

func show_dialogue(dialogue):
	var dialogue_object
	if dialogue is int:
		dialogue_object = %dialogues.dialogues[dialogue]
	else:
		dialogue_object = dialogue
	construct_dialogue(dialogue_object)
	open()

func construct_dialogue(dialogue_object):
	var alltext = ""
	for line in dialogue_object.lines:
		alltext = alltext+line.text+"\n"
	alltext = alltext+"\n"
	$contents/text.text = alltext
	var response_count = 0
	for response in dialogue_object.responses:
		var node = $contents/responses.get_child(response_count)
		node.set_disabled(false)
		node.show()
		node.text = response[0]
		if response.size() > 1:
			response_functions[response_count] = response[1]
		if response.size() > 2:
			response_arguments[response_count] = response[2]
		response_count += 1
	# hide rest of the responses
	for i in range(response_count,5):
		var node = $contents/responses.get_child(i)
		node.set_disabled(true)
		node.hide()

func open():
	%logic.set_input_handler(&"menu")
	show()
	$very_short_timer.start()

func close():
	%logic.set_input_handler(&"fps")
	hide()

func execute_function(index):
	if response_arguments.size() == 0:
		close()
	else:
		if index in response_functions.keys() and index in response_arguments.keys():
			response_functions[index].call_deferred(response_arguments[index])
		else:
			response_functions[index].call_deferred()
	response_functions.clear()
	response_arguments.clear()

func _on_response_1_pressed():
	close()
	execute_function(0)

func _on_response_2_pressed():
	close()
	execute_function(1)

func _on_response_3_pressed():
	close()
	execute_function(2)

func _on_response_4_pressed():
	close()
	execute_function(3)
	
func _on_response_5_pressed():
	close()
	execute_function(4)

func _on_very_short_timer_timeout():
	$contents/responses/response1.grab_focus()
