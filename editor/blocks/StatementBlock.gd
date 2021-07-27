extends VBoxContainer

onready var block_canvas = get_parent()
onready var parts = $Parts

var insert_area = null

onready var connect_area = $Parts/Top/ConnectArea

var block_ID = ""
var component_dict = {
	
}

#this code is piss

var dragging = false
var drag_offset = Vector2(0,0)
var drag_pos = Vector2(0,0)

var parent = null


func connect_to_bottom(var bottom):
	block_canvas.remove_child(self)
	bottom.parent_block.add_child(self)
	bottom.accept_connect()
	parent = bottom.parent_block

func remove_from_bottom():
	var bottom = parent.get_node("Parts/Bottom")
	
	parent.remove_child(self)
	block_canvas.add_child(self)
	parent = null
	bottom.accept_disconnect()
	
	
func connect_to_opening(var opening):
	block_canvas.remove_child(self)
	opening.block_container.add_child(self)
	opening.accept_connect()
	parent = opening

func remove_from_opening():
	
	parent.block_container.remove_child(self)
	block_canvas.add_child(self)
	parent.accept_disconnect()
	parent = null

func start_drag():
	dragging = true
	drag_offset = rect_global_position - get_global_mouse_position()
	drag_pos = get_global_mouse_position()
	if connect_area != null:
		if parent == null:
			connect_area.monitorable = true
	set_process(true)
	raise()

func stop_drag():
	dragging = false
	set_process(false)
	if connect_area != null:
		connect_area.monitorable = false
		if block_canvas.highlighted_connects.size() > 0:
			
			if block_canvas.highlighted_connects.back().is_in_group("bottom"):
				connect_to_bottom(block_canvas.highlighted_connects.back())
			else:
				connect_to_opening(block_canvas.highlighted_connects.back())
				
			block_canvas.highlighted_connects = []


func parts_gui_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_drag()
			else:
				stop_drag()

func _process(_delta):

	if dragging:
		if parent == null:
			rect_global_position = get_global_mouse_position() + drag_offset
			if Input.is_action_just_released("mouse_left"):
				stop_drag()
		else:
			if get_global_mouse_position().distance_to(drag_pos) > 50.0:
				if parent.is_in_group("opening"):
					remove_from_opening()
				else:
					remove_from_bottom()
				connect_area.monitorable = true
	

func refresh():
	rect_size = Vector2(0,0)
	if parent != null:
		parent.refresh()
	
	


func _ready():
	
# warning-ignore:return_value_discarded
	$Parts.connect("gui_input",self,"parts_gui_input")
	set_process(false)
	
