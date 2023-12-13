extends Node

enum result_types {Quit, Accept, More}

var dialogues = {}
var responses = {}

class Dialogue:
	var text = ""
	var responses = []
	
	# it is possible for 5 responses (snowline/llewydrconvo.s:26
	func _init(new_text,new_responses=[]):
		text = new_text
		for response in new_responses:
			responses.append(response)
	
	func add_response(response):
		responses.append(response)

class Response:
	var text = ""
	var result = null
	var function = null
	
	func _init(new_text, new_result=result_types.Quit, new_function=null):
		text = new_text
		result = new_result
		function = new_function
	
	func add_function(new_function):
		function = new_function
	
	
	

#class DialogueTree:
	
