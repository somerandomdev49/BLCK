extends "res://editor/blocks/components/Number.gd"



func empty_convert():
	
	return (str($Visual/InputContainer/SpinBox.value) + "g")
	
