extends PanelContainer

onready var block_canvas = get_parent()

var dragging = false
var drag_offset = Vector2(0,0)
var drag_pos = Vector2(0,0)

var data_type = -1

onready var insert_area = $InsertArea

var component_dict = {
	
}

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
	

var parent_input = null

func start_drag():
	dragging = true
	drag_offset = rect_global_position - get_global_mouse_position()
	drag_pos = get_global_mouse_position()
	set_process(true)
	if parent_input == null:
		$InsertArea.monitorable = true
	raise()
	
func stop_drag():
	dragging = false
	set_process(false)
	$InsertArea.monitorable = false
	if block_canvas.highlighted_input != null:
		insert_into_input(block_canvas.highlighted_input)

func _gui_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_drag()
			else:
				stop_drag()

func _ready():
	set_process(false)
	get_stylebox("panel").content_margin_bottom = 12
	get_stylebox("panel").content_margin_top = 12
	get_stylebox("panel").content_margin_left = 24
	get_stylebox("panel").content_margin_right = 24


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
	


func addComponent(var component):
	
	var new_component = null
	
	match component.type:
		BlockHandler.Components.TEXT:
			new_component = BlockHandler.TextComponent.instance()
			new_component.text = component.text
		BlockHandler.Components.NUMBER:
			new_component = BlockHandler.NumberComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.NUMBER
		BlockHandler.Components.COUNTER:
			new_component = BlockHandler.CounterComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.COUNTER
		BlockHandler.Components.GROUP:
			new_component = BlockHandler.GroupComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.GROUP
		BlockHandler.Components.COLOR:
			new_component = BlockHandler.ColorComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.COLOR
		BlockHandler.Components.BLOCK:
			new_component = BlockHandler.BlockComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.BLOCK
		BlockHandler.Components.ITEM:
			new_component = BlockHandler.ItemComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.ITEM
		BlockHandler.Components.STRING:
			new_component = BlockHandler.StringComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.STRING
		BlockHandler.Components.BOOLEAN:
			new_component = BlockHandler.BooleanComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.BOOLEAN
		BlockHandler.Components.OBJECT:
			new_component = BlockHandler.ObjectComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.OBJECT
		BlockHandler.Components.DICT:
			new_component = BlockHandler.DictComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.DICT
		BlockHandler.Components.ARRAY:
			new_component = BlockHandler.ArrayComponent.instance()
			new_component.data_type = BlockHandler.BlockTypes.ARRAY
		BlockHandler.Components.LIST:
			new_component = BlockHandler.ListComponent.instance()
			new_component.add_items(component.options)
		BlockHandler.Components.COLOR_PICKER:
			new_component = BlockHandler.ColorPickerComponent.instance()
		BlockHandler.Components.UNIVERSAL:
			new_component = BlockHandler.UniversalComponent.instance()
	
	$HBoxContainer/Components.add_child(new_component)
	return new_component
	
	
