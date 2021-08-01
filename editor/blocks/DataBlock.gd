extends PanelContainer

onready var block_canvas = get_parent()

var dragging = false
var drag_offset = Vector2(0,0)
var drag_pos = Vector2(0,0)

var data_type = -1

onready var insert_area = $InsertArea
onready var tooltip = $TooltipAnchor/BlockToolTip

var block_ID = ""
var component_dict = {
	
}

var parent_input = null

func build(var type):
	
	if BlockHandler.SPECIAL_TYPES.has(type):
		var type_info = BlockHandler.SPECIAL_TYPES[type]
		if type_info.icon != null:
			$HBoxContainer/Icon.texture = type_info.icon
			$HBoxContainer/Icon.show()
		add_stylebox_override("panel",type_info.block_style)
	else:
		add_stylebox_override("panel",BlockHandler.SpecialBlockStyle)
		
	$TooltipAnchor/BlockToolTip.set_type(type)
	data_type = type
	

#this code is piss

func refresh():
	rect_size = Vector2(0,0)
	if parent_input != null:
		get_parent().parent_block.refresh()
	

func insert_into_input(var input):
	block_canvas.remove_child(self)
	input.add_child(self)
	input.accept_insert()
	parent_input = input

func remove_from_input():
	parent_input.remove_child(self)
	block_canvas.add_child(self)
	parent_input.accept_remove()
	parent_input = null
	mouse_exited()


func start_drag():
	dragging = true
	drag_offset = rect_global_position - get_global_mouse_position()
	drag_pos = get_global_mouse_position()
	set_process(true)
	if parent_input == null:
		$InsertArea.monitorable = true
	raise()
	mouse_exited()
	
func stop_drag():
	dragging = false
	set_process(false)
	$InsertArea.monitorable = false
	if block_canvas.highlighted_input != null:
		insert_into_input(block_canvas.highlighted_input)

func _gui_input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.pressed:
					start_drag()
				else:
					stop_drag()
			BUTTON_RIGHT:
				if event.pressed:
					print( ConversionHandler.convert_block(self, 0) )


func mouse_entered():
	$HoverTimer.start()

func mouse_exited():
	$HoverTimer.stop()
	$Tween.stop(tooltip,"modulate:a")
	$Tween.interpolate_property(tooltip,"modulate:a",null,0,0.25,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
func hover_timeout():
	$HoverTimer.stop()
	#$Tween.stop(tooltip,"modulate:a")
	#$Tween.interpolate_property(tooltip,"modulate:a",null,1,0.25,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	#$Tween.start()
	
func _ready():
	
	tooltip.modulate.a = 0
	
	set_process(false)
	get_stylebox("panel").content_margin_bottom = 12
	get_stylebox("panel").content_margin_top = 12
	get_stylebox("panel").content_margin_left = 24
	get_stylebox("panel").content_margin_right = 24
	
	connect("mouse_entered",self,"mouse_entered")
	connect("mouse_exited",self,"mouse_exited")
	
	$HoverTimer.connect("timeout",self,"hover_timeout")
	
	


func _process(_delta):
	
	if dragging:
		if parent_input == null:
			rect_global_position = get_global_mouse_position() + drag_offset
			if Input.is_action_just_released("mouse_left"):
				stop_drag()
		else:
			if get_global_mouse_position().distance_to(drag_pos) > 50.0:
				remove_from_input()
				$InsertArea.monitorable = true
	


func add_component(var component):
	
	var new_component = null
	
	match component.type:
		BlockHandler.Components.TEXT:
			new_component = BlockHandler.TextComponent.instance()
			new_component.text = component.text
		BlockHandler.Components.DATA:
			new_component = BlockHandler.DataComponent.instance()
			new_component.build(component.data_types)
		BlockHandler.Components.LIST:
			new_component = BlockHandler.ListComponent.instance()
			new_component.add_items(component.options)
		BlockHandler.Components.COLOR_PICKER:
			new_component = BlockHandler.ColorPickerComponent.instance()
	
	$HBoxContainer/Components.add_child(new_component)
	return new_component
	
	
