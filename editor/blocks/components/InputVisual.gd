extends PanelContainer

onready var InputComponent = get_parent()


func text_changed(_text):
	InputComponent.rect_size.x = 0
	InputComponent.parent_block.refresh()
	

func _ready():
	
	$InputContainer/NumInput.get_line_edit().context_menu_enabled = false
	$InputContainer/StringInput.connect("text_changed",self,"text_changed")
	
	
	pass
