extends Node

#Statement Parts
const StatementBlock = preload("res://editor/blocks/StatementBlock.tscn")

const StatementBottom = preload("res://editor/blocks/statement/Bottom.tscn")
const StatementTop = preload("res://editor/blocks/statement/Top.tscn")
const StatementMiddle = preload("res://editor/blocks/statement/Middle.tscn")

const StatementHead = preload("res://editor/blocks/statement/Head.tscn")
const StatementEnd = preload("res://editor/blocks/statement/End.tscn")

#Components
const TextComponent = preload("res://editor/blocks/components/Text.tscn")

const NumberComponent = preload("res://editor/blocks/components/Number.tscn")
const BooleanComponent = preload("res://editor/blocks/components/Boolean.tscn")
const StringComponent = preload("res://editor/blocks/components/String.tscn")

const CounterComponent = preload("res://editor/blocks/components/Counter.tscn")
const GroupComponent = preload("res://editor/blocks/components/Group.tscn")
const ColorComponent = preload("res://editor/blocks/components/Color.tscn")
const BlockComponent = preload("res://editor/blocks/components/Block.tscn")
const ItemComponent = preload("res://editor/blocks/components/Item.tscn")

const ObjectComponent = preload("res://editor/blocks/components/Object.tscn")
const DictComponent = preload("res://editor/blocks/components/Dictionary.tscn")
const ArrayComponent = preload("res://editor/blocks/components/Array.tscn")

const ListComponent = preload("res://editor/blocks/components/List.tscn")
const ColorPickerComponent = preload("res://editor/blocks/components/ColorPicker.tscn")
const UniversalComponent = preload("res://editor/blocks/components/Universal.tscn")

const OpeningComponent = preload("res://editor/blocks/statement/Opening.tscn")

#Data Blocks
const NumberBlock = preload("res://editor/blocks/numlike/NumberBlock.tscn")
const CounterBlock = preload("res://editor/blocks/numlike/CounterBlock.tscn")
const GroupBlock = preload("res://editor/blocks/numlike/GroupBlock.tscn")
const ColorBlock = preload("res://editor/blocks/numlike/ColorBlock.tscn")
const BlockBlock = preload("res://editor/blocks/numlike/BlockBlock.tscn")
const ItemBlock = preload("res://editor/blocks/numlike/ItemBlock.tscn")

const StringBlock = preload("res://editor/blocks/StringBlock.tscn")

const BooleanBlock = preload("res://editor/blocks/BooleanBlock.tscn")

const ObjectBlock = preload("res://editor/blocks/special/ObjectBlock.tscn")
const DictBlock = preload("res://editor/blocks/special/DictBlock.tscn")
const ArrayBlock = preload("res://editor/blocks/special/ArrayBlock.tscn")


enum BlockTypes{
	
	HEADER,
	STATEMENT,
	END,
	
	NUMBER,
	COUNTER,
	GROUP,
	COLOR,
	BLOCK,
	ITEM,
	
	STRING,
	
	BOOLEAN,
	
	OBJECT,
	DICT,
	ARRAY,
	
}

const BLOCK_TYPE_NAMES = {
	
	"header": BlockTypes.HEADER,
	"statement": BlockTypes.STATEMENT,
	"end": BlockTypes.END,
	"number": BlockTypes.NUMBER,
	"counter": BlockTypes.COUNTER,
	"group": BlockTypes.GROUP,
	"color": BlockTypes.COLOR,
	"block": BlockTypes.BLOCK,
	"item": BlockTypes.ITEM,
	"string": BlockTypes.STRING,
	"boolean": BlockTypes.BOOLEAN,
	"object": BlockTypes.OBJECT,
	"dict": BlockTypes.DICT,
	"array": BlockTypes.ARRAY,
	
}

enum Components{
	
	TEXT,
	OPENING,
	
	NUMBER,
	COUNTER,
	GROUP,
	COLOR,
	BLOCK,
	ITEM,
	
	STRING,
	
	BOOLEAN,
	
	OBJECT,
	DICT,
	ARRAY,
	
	LIST,
	COLOR_PICKER,
	
	UNIVERSAL,
	
}

const COMPONENT_NAMES = {
	#Components.TEXT: 
	"open": Components.OPENING,
	
	"n": Components.NUMBER,
	"#":  Components.COUNTER,
	"g": Components.GROUP,
	"c": Components.COLOR,
	"b": Components.BLOCK,
	"i": Components.ITEM,
	
	"str": Components.STRING,
	
	"bool": Components.BOOLEAN,
	
	"obj": Components.OBJECT,
	"dict": Components.DICT,
	"arr": Components.ARRAY,
	
	"list": Components.LIST,
	"pick": Components.COLOR_PICKER,
	"any": Components.UNIVERSAL,
}

func parseDef(var def):
	
	
	var block_type = ""
	var category = ""
	
	var components = []
	
	var i = 0
	
	while def[i] != '|':
		block_type += def[i]
		i += 1
	block_type = BLOCK_TYPE_NAMES[block_type]
	i += 1
	while def[i] != '|':
		category += def[i]
		i += 1
	category = EditorHandler.CATEGORY_NAMES[category]
	i += 1
	
	var new_text = ""
	
	while i < def.length():
		if def[i] == '%':
			
			if new_text.strip_edges() != "":
				components.append({"type": Components.TEXT, "text": new_text.strip_edges()})
				new_text = ""
				
			i += 1
			var component = ""
			var component_name = ""
			while def[i] != '(':
				component += def[i]
				i += 1
			component = COMPONENT_NAMES[component]
			i += 1
			while def[i] != ')':
				component_name += def[i]
				i += 1
			i += 1
			if component == Components.LIST:
				i += 1
				var options = []
				var option_name = ""
				while def[i] != ']':
					if def[i] != ',':
						option_name += def[i]
					else:
						options.append(option_name.strip_edges())
						option_name = ""
					i += 1
				options.append(option_name.strip_edges())
				i += 1
				components.append({"type": component, "name": component_name, "options": options})
			else:
				components.append({"type": component, "name": component_name})
		else:
			
			if def[i] == '`':
				i += 1
				new_text += def[i]
				i += 1
			else:
				new_text += def[i]
				i += 1
	
	if new_text.strip_edges() != "":
		components.append({"type": Components.TEXT, "text": new_text.strip_edges()})
		new_text = ""
	
	return {
		"block_type": block_type,
		"category": category,
		"components": components
	}
	
func _ready():
	
	for i in Blocks.BLOCK_DEFINITIONS:
		BLOCK_DEFINITIONS_PARSED[i] = parseDef(Blocks.BLOCK_DEFINITIONS[i]["def"])
	
	
	
		
const BLOCK_DEFINITIONS_PARSED = {
		
}

func buildBlock(var block_ID):
	
	var definition = BLOCK_DEFINITIONS_PARSED[block_ID]
	
	match definition.block_type:
		BlockTypes.STATEMENT:
			return buildStatement(definition.components,definition.block_type,definition.category)
		BlockTypes.HEADER:
			return buildStatement(definition.components,definition.block_type,definition.category)
		BlockTypes.END:
			return buildStatement(definition.components,definition.block_type,definition.category)
		BlockTypes.HEADER:
			return null
		_:
			return buildData(definition.components,definition.block_type,definition.category)
	

func buildData(var components, var block_type, var category):
	
	var new_block = null
	
	match block_type:
		BlockTypes.NUMBER:
			new_block = NumberBlock.instance()
		BlockTypes.COUNTER:
			new_block = CounterBlock.instance()
		BlockTypes.GROUP:
			new_block = GroupBlock.instance()
		BlockTypes.COLOR:
			new_block = ColorBlock.instance()
		BlockTypes.BLOCK:
			new_block = BlockBlock.instance()
		BlockTypes.ITEM:
			new_block = ItemBlock.instance()
		BlockTypes.STRING:
			new_block = StringBlock.instance()
		BlockTypes.BOOLEAN:
			new_block = BooleanBlock.instance()
		BlockTypes.OBJECT:
			new_block = ObjectBlock.instance()
		BlockTypes.DICT:
			new_block = DictBlock.instance()
		BlockTypes.ARRAY:
			new_block = ArrayBlock.instance()
			
	new_block.self_modulate = EditorHandler.CATEGORY_COLORS[category]
	
	new_block.data_type = block_type
	
	for component in components:
		
		if component.type != BlockHandler.Components.OPENING:
			
			if component.type != BlockHandler.Components.TEXT:
				var new_component = new_block.addComponent(component)
				new_block.component_dict[component.name] = new_component
				new_component.parent_block = new_block
			else:
				new_block.addComponent(component)
	
	return new_block
	
	


func buildStatement(var components, var block_type, var category):
	
	var new_block = StatementBlock.instance()
	
	var new_part = null
	
	if block_type == BlockTypes.HEADER:
		new_part = BlockHandler.StatementHead.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[category]
		new_block.get_node("Parts").add_child(new_part)
	else:
		new_part = BlockHandler.StatementTop.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[category]
		new_block.get_node("Parts").add_child(new_part)
	
	var current_middle = null
	
	for component in components:
		
		if component.type != BlockHandler.Components.OPENING:
			if current_middle == null:
				current_middle = BlockHandler.StatementMiddle.instance()
				current_middle.self_modulate = EditorHandler.CATEGORY_COLORS[category]
				new_block.get_node("Parts").add_child(current_middle)
				
			if component.type != BlockHandler.Components.TEXT:
				var new_component = current_middle.addComponent(component)
				new_block.component_dict[component.name] = new_component
				new_component.parent_block = new_block
			else:
				current_middle.addComponent(component)
		else:
			var new_component = BlockHandler.OpeningComponent.instance()
			new_component.parent_block = new_block
			new_block.get_node("Parts").add_child(new_component)
			new_block.component_dict[component.name] = new_component
			new_component.set_color(EditorHandler.CATEGORY_COLORS[category])
			current_middle = null
	
	if block_type == BlockTypes.END:
		new_part = BlockHandler.StatementEnd.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[category]
		new_block.get_node("Parts").add_child(new_part)
	else:
		new_part = BlockHandler.StatementBottom.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[category]
		new_block.get_node("Parts").add_child(new_part)
	
	return new_block
	




