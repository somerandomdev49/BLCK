extends PanelContainer

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
	
	$Components.add_child(new_component)
	return new_component
	
	


