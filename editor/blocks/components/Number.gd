extends "res://editor/blocks/components/InputComponent.gd"


func _ready():
	
	$Visual/InputContainer/SpinBox.get_line_edit().context_menu_enabled = false
	


func empty_convert():
	
	return str($Visual/InputContainer/SpinBox.value)
	

