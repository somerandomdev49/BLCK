extends ColorPickerButton

var parent_block = null

func _toggled(button_pressed):
	
	set_process(button_pressed)
	if button_pressed:
		parent_block.raise()
	
func _process(_delta): #the popup menu is very badly offset if i dont do this
	get_popup().rect_global_position = rect_global_position + Vector2(0,5 + rect_min_size.y)
	get_popup().rect_scale = Vector2(2,2)

func _ready():
	
	set_process(false)
	
	pass
