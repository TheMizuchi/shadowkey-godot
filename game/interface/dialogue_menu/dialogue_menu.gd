extends Node2D

var response_functions = {}
var response_arguments = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func construct_dialogue(contents):
	#print(contents)
	var alltext = ""
	for line in contents.lines:
		alltext = alltext+line.text+"\n"
	$contents/text.text = alltext
	var response_count = 0
	for response in contents.responses:
		var node = $contents/responses.get_child(response_count)
		node.show()
		node.text = response[0]
		if response.size() > 1:
			response_functions[response_count] = response[1]
			response_arguments[response_count] = response[2]
		response_count += 1
	# hide rest of the responses
	for i in range(response_count,5):
		$contents/responses.get_child(i).hide()

func open():
	%logic.set_input_handler(&"menu")
	show()

func close():
	%logic.set_input_handler(&"fps")
	hide()

func execute_function(index):
	if response_arguments.size() == 0:
		close()
	else:
		response_functions[index].call(response_arguments[index])

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
