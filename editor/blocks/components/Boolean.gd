extends "res://editor/blocks/components/InputComponent.gd"



func empty_convert():
	return "true" if $Visual/InputContainer/CheckButton.pressed else "false"
	
