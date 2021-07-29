extends Node


func repl(var string, var array):
	var i = 0
	var output = ""
	for element in array:
		i = string.find('`')
		output += string.substr(0,i) + str(element)
		string = string.substr(i+1)
	output += string
	return output
	


func convert_component(var input):
	
	var connected_block = input.get_connected_block()
	if connected_block != null:
		return convert_block(connected_block)
	else:
		return input.empty_convert()
	


func convert_block(var block):
	
	var block_ID = block.block_ID
	var comp = {}
	for i in block.component_dict:
		comp[i] = convert_component( block.component_dict[i] )
	
	match block_ID:
		"PLUS":
			return repl("(` + `)",[ comp["a"], comp["b"] ])
		"MINUS":
			return repl("(` - `)",[ comp["a"], comp["b"] ])
		"MULT":
			return repl("(` * `)",[ comp["a"], comp["b"] ])
		"DIV":
			return repl("(` / `)",[ comp["a"], comp["b"] ])
		
	
	return ""
	
	
