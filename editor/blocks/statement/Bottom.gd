extends NinePatchRect

onready var parent_block = get_node("../..")
var drag_area = null

func highlight():
	
	for i in parent_block.block_canvas.highlighted_connects:
		i.unhighlight()
	
	$Tween.stop_all()
	$Tween.interpolate_property($Highlight,"modulate:a",null,1,0.075)
	$Tween.start()
	
func unhighlight():
	$Tween.stop_all()
	$Tween.interpolate_property($Highlight,"modulate:a",null,0,0.075)
	$Tween.start()

func area_entered(area):
	
	if area != parent_block.insert_area: #should always be the case but eh
		drag_area = area
		highlight()
		parent_block.block_canvas.highlighted_connects.append(self)

func area_exited(area):

	if area == drag_area:
		drag_area = null
		unhighlight()
		parent_block.block_canvas.highlighted_connects.erase(self)
		if parent_block.block_canvas.highlighted_connects.size() > 0:
			parent_block.block_canvas.highlighted_connects.back().highlight()
		
		


func accept_connect():
	
	parent_block.refresh()
	$ConnectDetect.monitoring = false
	
func accept_disconnect():
	
	parent_block.refresh()
	$ConnectDetect.monitoring = true
	


func _ready():
	
# warning-ignore:return_value_discarded
	$ConnectDetect.connect("area_entered",self,"area_entered")
# warning-ignore:return_value_discarded
	$ConnectDetect.connect("area_exited",self,"area_exited")
	
	pass
