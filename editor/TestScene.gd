extends Node2D


var moving_camera = false
var prev_mouse_pos = Vector2(0,0)
var prev_camera_pos = Vector2(0,0)


func _ready():
	
	var j = 0
	for i in BlockHandler.BLOCK_DEFINITIONS:
		var new_block = BlockHandler.build_block(i)
		new_block.rect_position = Vector2(0,j)
		j += 150
		$BlockCanvas.add_child(new_block)
	
	var output = []
	OS.execute("spwn",[],true,output)
	for i in output:
		print(i)
	
	

func _process(_delta):
	
	if Input.is_action_just_pressed("mouse_middle"):
		moving_camera = true
		prev_mouse_pos = get_viewport().get_mouse_position()
		prev_camera_pos = $Camera.position
	if Input.is_action_just_released("mouse_middle"):
		moving_camera = false
		
	if moving_camera:
		$Camera.position = prev_camera_pos - (get_viewport().get_mouse_position() - prev_mouse_pos)*$Camera.zoom
	
	if Input.is_action_just_pressed("screenshot"):
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("user://screenshot.png")
	

