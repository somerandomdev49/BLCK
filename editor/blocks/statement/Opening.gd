extends VBoxContainer

var parent_block = null
var drag_area = null

onready var block_container = $Content/Break/BlockContainer

func set_color(var color):
	
	$Open.self_modulate = color
	$Content/Visual.self_modulate = color
	$Close.self_modulate = color
	

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
	
	$ConnectDetect.monitoring = true
	refresh()


	
func refresh():
	$Content.rect_min_size.y = max(0,$Content/Break/BlockContainer.rect_size.y - 35)
	#$Content.rect_size.y = 0
	#$Content/Break.rect_size.y = 0
	$Content/Break/BlockContainer.rect_size.y = 0
	parent_block.refresh()
	
func _ready():
	
# warning-ignore:return_value_discarded
	$ConnectDetect.connect("area_entered",self,"area_entered")
# warning-ignore:return_value_discarded
	$ConnectDetect.connect("area_exited",self,"area_exited")
	
# warning-ignore:return_value_discarded
	$Content/Break/BlockContainer.connect("resized",self,"refresh")
	
	pass

