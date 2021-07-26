extends Control

var parent_block = null
var data_type = -1

var drag_area = null

func highlight(var area):
	
	if parent_block.block_canvas.highlighted_input != null:
		parent_block.block_canvas.highlighted_input.unhighlight()
	
	drag_area = area
	
	$Tween.stop_all()
	$Tween.interpolate_property($Visual,"modulate:a",null,0.5,0.075)
	$Tween.start()
	
	parent_block.block_canvas.highlighted_input = self
	
func unhighlight():
	drag_area = null
	
	$Tween.stop_all()
	$Tween.interpolate_property($Visual,"modulate:a",null,1,0.075)
	$Tween.start()
	
	parent_block.block_canvas.highlighted_input = null
	
func accept_insert():
	$Visual.hide()
	parent_block.refresh()
	$Visual/InsertDetect.monitoring = false
	
func accept_remove():
	$Visual.show()
	rect_size = Vector2(0,0)
	parent_block.refresh()
	$Visual/InsertDetect.monitoring = true
	

func area_entered(area):
	
	if parent_block.is_in_group("statement_block"):
		if data_type == area.get_parent().data_type || data_type == -1:
			highlight(area)
	elif area != parent_block.insert_area:
		if data_type == area.get_parent().data_type || data_type == -1:
			highlight(area)

func area_exited(area):
	
	if area == drag_area:
		unhighlight()


func _ready():
# warning-ignore:return_value_discarded
	$Visual/InsertDetect.connect("area_entered",self,"area_entered")
# warning-ignore:return_value_discarded
	$Visual/InsertDetect.connect("area_exited",self,"area_exited")

