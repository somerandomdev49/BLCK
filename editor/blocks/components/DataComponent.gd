extends Control

var parent_block = null
var data_types = -1

var drag_area = null

func empty_convert():
	if data_types.size() > 0:
		match data_types[0]:
			"@number":
				return str($Visual/InputContainer/NumInput.value)
			"@counter":
				return "counter(0)"
			"@group":
				return str($Visual/InputContainer/NumInput.value) + "g"
			"@color":
				return str($Visual/InputContainer/NumInput.value) + "c"
			"@block":
				return str($Visual/InputContainer/NumInput.value) + "b"
			"@item":
				return str($Visual/InputContainer/NumInput.value) + "i"
			"@string":
				return $Visual/InputContainer/StringInput.text
			"@bool":
				return ("true" if $Visual/InputContainer/BoolInput.pressed else "false")
			"@object":
				return "obj{}"
			"@dict":
				return "{}"
			"@array":
				return "[]"
			_:
				return "null"
			"@object_key":
				return $Visual/InputContainer/StringInput.text
			
	else:
		return "null"




func build(var types):
	if types.size() == 0:
		$Visual/InputContainer/Icon.texture = BlockHandler.AnyIcon
		$Visual/InputContainer/Icon.show()
		$Visual.add_stylebox_override("panel",BlockHandler.UniversalInputStyle)
	elif types.size() == 1:
		var type = types[0]
		if BlockHandler.SPECIAL_TYPES.has(type):
			var type_info = BlockHandler.SPECIAL_TYPES[type]
			if type_info.icon != null:
				$Visual/InputContainer/Icon.texture = type_info.icon
				$Visual/InputContainer/Icon.show()
			$Visual.add_stylebox_override("panel",type_info.input_style)
			
			match type_info.input:
				BlockHandler.SpecialInputs.NUMBER:
					$Visual/InputContainer/NumInput.show()
				BlockHandler.SpecialInputs.STRING:
					$Visual/InputContainer/StringInput.show()
				BlockHandler.SpecialInputs.BOOLEAN:
					$Visual/InputContainer/BoolInput.show()
		else:
			$Visual/InputContainer/TypeLabel.text = type
			$Visual/InputContainer/TypeLabel.show()
			$Visual.add_stylebox_override("panel",BlockHandler.SpecialInputStyle)
	else:
		var type_text = types[0]
		
		for i in range(1,types.size()):
			type_text += "\n" + types[i]
		
		$Visual/InputContainer/TypeLabel.text = type_text
		$Visual/InputContainer/TypeLabel.show()
		$Visual.add_stylebox_override("panel",BlockHandler.UniversalInputStyle)
		
	data_types = types
	
	




func get_connected_block():
	if get_child_count() > 1:
		return get_child(1)
	else:
		return null

func highlight(var area):
	
	if parent_block.block_canvas.highlighted_input != null:
		parent_block.block_canvas.highlighted_input.unhighlight()
	
	drag_area = area
	
	$Visual/Tween.stop($Visual,"modulate:a")
	$Visual/Tween.interpolate_property($Visual,"modulate:a",null,0.5,0.075)
	$Visual/Tween.start()
	
	parent_block.block_canvas.highlighted_input = self
	
func unhighlight():
	drag_area = null
	
	$Visual/Tween.stop($Visual,"modulate:a")
	$Visual/Tween.interpolate_property($Visual,"modulate:a",null,1,0.075)
	$Visual/Tween.start()
	
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
	
	if parent_block.is_in_group("statement_like"):
		if area.get_parent().data_type in data_types || data_types == [] || area.get_parent().data_type == "":
			highlight(area)
	elif area != parent_block.insert_area:
		if area.get_parent().data_type in data_types || data_types == [] || area.get_parent().data_type == "":
			highlight(area)

func area_exited(area):
	
	if area == drag_area:
		unhighlight()


func _ready():
	
# warning-ignore:return_value_discarded
	$Visual/InsertDetect.connect("area_entered",self,"area_entered")
# warning-ignore:return_value_discarded
	$Visual/InsertDetect.connect("area_exited",self,"area_exited")

