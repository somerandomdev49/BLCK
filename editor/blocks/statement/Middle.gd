extends PanelContainer

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
	
	$Components.add_child(new_component)
	return new_component
	
	


