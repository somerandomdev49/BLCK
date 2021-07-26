extends Node2D

var dragging = false
var dragOffset = Vector2(0,0)

func screen_mouse_pos():
	return OS.get_window_position() + get_global_mouse_position()

func panel_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				dragging = true
				dragOffset = OS.get_window_position() - screen_mouse_pos()
			else:
				dragging = false

func _process(delta):
	
	if dragging:
		
		OS.window_position = screen_mouse_pos() + dragOffset
		


func _ready():
	
	OS.window_borderless = true
	
	get_tree().get_root().set_transparent_background(true)
	$AnimationPlayer.play("intro")
	
	$Menu/ShadowMargin/Panel.connect("gui_input",self,"panel_input")
	
	pass # Replace with function body.
