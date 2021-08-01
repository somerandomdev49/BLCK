extends OptionButton

var parent_block = null

func empty_convert():
	return text

func add_items(var option_array):
	
	for i in option_array:
		add_item(i)
	


func item_selected(_index):
	
	parent_block.refresh()
	
	pass

func _toggled(button_pressed):
	
	set_process(button_pressed)
	if button_pressed:
		parent_block.raise()
	

func _process(_delta): #the popup menu is very badly offset if i dont do this
	#kinda icky but yea
	get_popup().rect_global_position = rect_global_position + rect_min_size + Vector2(0,5)
	
	

#so this lady goes to the vet with her very fat cat
#and the veterinarian picks her cat up and examines it closely
#and says
#"im afraid i'll have to put your cat down"
#"why!?? because it's fat?"
#"yes, my arms hurt"

func _ready():

# warning-ignore:return_value_discarded
	connect("item_selected",self,"item_selected")
	set_process(false)
	
	pass
