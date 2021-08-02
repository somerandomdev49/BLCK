extends Button

var canvas = null
var camera = null

func _pressed():
	
	var new_block = BlockHandler.build_block(text)
	new_block.rect_position = camera.position
	canvas.add_child(new_block)
	

