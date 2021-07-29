extends "res://editor/blocks/components/InputComponent.gd"

func textChanged(_text):
	
	rect_size.x = 0
	parent_block.refresh()
	


func _ready():
	
# warning-ignore:return_value_discarded
	$Visual/InputContainer/LineEdit.connect("text_changed",self,"textChanged")
	
	pass


func empty_convert():
	
	return $Visual/InputContainer/LineEdit.text
	
