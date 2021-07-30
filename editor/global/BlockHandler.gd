extends Node

#Block Types
const StatementBlock = preload("res://editor/blocks/StatementBlock.tscn")
const DataBlock = preload("res://editor/blocks/DataBlock.tscn")

#Statement Parts

const StatementBottom = preload("res://editor/blocks/statement/Bottom.tscn")
const StatementTop = preload("res://editor/blocks/statement/Top.tscn")
const StatementMiddle = preload("res://editor/blocks/statement/Middle.tscn")

const StatementHead = preload("res://editor/blocks/statement/Head.tscn")
const StatementEnd = preload("res://editor/blocks/statement/End.tscn")

#Components
const TextComponent = preload("res://editor/blocks/components/Text.tscn")
const DataComponent = preload("res://editor/blocks/components/DataComponent.tscn")
const OpeningComponent = preload("res://editor/blocks/statement/Opening.tscn")
const ColorPickerComponent = preload("res://editor/blocks/components/ColorPicker.tscn")
const ListComponent = preload("res://editor/blocks/components/List.tscn")

#Icons
const AnyIcon = preload("res://assets/editor/blocks/icons/any.png")
const ArrayIcon = preload("res://assets/editor/blocks/icons/array.png")
const BlockIcon = preload("res://assets/editor/blocks/icons/block.png")
const ColorIcon = preload("res://assets/editor/blocks/icons/color.png")
const CounterIcon = preload("res://assets/editor/blocks/icons/counter.png")
const DictIcon = preload("res://assets/editor/blocks/icons/dict.png")
const GroupIcon = preload("res://assets/editor/blocks/icons/group.png")
const ItemIcon = preload("res://assets/editor/blocks/icons/item.png")
const ObjectIcon = preload("res://assets/editor/blocks/icons/object.png")

#InputStyles
const NumStyleOffset = 0
const BoolStyleOffset = 72
const StringStyleOffset = 72*2
const SpecialStyleOffset = 72*3
const UniversalStyleOffset = 72*4

enum BlockTypes{
	STATEMENT,
	HEADER,
	END,
	DATA
}

enum Components{
	TEXT,
	OPENING,
	DATA,
	LIST,
	COLOR_PICKER,
}

enum SpecialInputs{
	NUMBER,
	STRING,
	BOOLEAN,
}

const SPECIAL_TYPES = {
	"@number": {
		"icon": null,
		"input": SpecialInputs.NUMBER,
		"style_offset": NumStyleOffset,
	},
	"@counter": {
		"icon": CounterIcon,
		"input": SpecialInputs.NUMBER,
		"style_offset": NumStyleOffset,
	},
	"@group": {
		"icon": GroupIcon,
		"input": SpecialInputs.NUMBER,
		"style": NumStyleOffset,
	},
	"@color": {
		"icon": ColorIcon,
		"input": SpecialInputs.NUMBER,
		"style_offset": NumStyleOffset,
	},
	"@block": {
		"icon": BlockIcon,
		"input": SpecialInputs.NUMBER,
		"style_offset": NumStyleOffset,
	},
	"@item": {
		"icon": ItemIcon,
		"input": SpecialInputs.NUMBER,
		"style_offset": NumStyleOffset,
	},
	"@string": {
		"icon": null,
		"input": SpecialInputs.STRING,
		"style_offset": StringStyleOffset,
	},
	"@boolean": {
		"icon": null,
		"input": SpecialInputs.BOOLEAN,
		"style_offset": BoolStyleOffset,
	},
	"@object": {
		"icon": ObjectIcon,
		"input": null,
		"style_offset": SpecialStyleOffset,
	},
	"@dict": {
		"icon": DictIcon,
		"input": null,
		"style_offset": SpecialStyleOffset,
	},
	"@array": {
		"icon": ArrayIcon,
		"input": null,
		"style_offset": SpecialStyleOffset,
	},
}

const ICON_TYPES = [
	"array",
	"block",
	"color",
	"counter",
	"dict",
	"group",
	"item",
	"object"
]

func text(var text):
	return {"type": Components.TEXT, "text": text}
	
func opening(var comp_name):
	return {"type": Components.OPENING, "name": comp_name}

func data(var data_types, var comp_name):
	return {"type": Components.DATA, "data_types": data_types, "name": comp_name}

func list(var options, var comp_name):
	return {"type":  Components.LIST, "options": options, "name": comp_name}

func picker(var alpha_allowed, var comp_name):
	return {"type":  Components.COLOR_PICKER, "alpha": alpha_allowed, "name": comp_name}

var BLOCK_DEFINITIONS = {
	
	"PLUS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("+"),
			data(["@number"], "b"),
		]
	},
	"MINUS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("-"),
			data(["@number"], "b"),
		]
	},
	"MULTIPLY": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("*"),
			data(["@number"], "b"),
		]
	}
	
}



func build_block(var block_ID):

	var definition = BLOCK_DEFINITIONS[block_ID]

	var new_block = null

	match definition.block_type:
		BlockTypes.STATEMENT:
			new_block = build_statement(definition)
		BlockTypes.HEADER:
			new_block = build_statement(definition)
		BlockTypes.END:
			new_block = build_statement(definition)
		BlockTypes.DATA:
			new_block = build_data(definition)

	new_block.block_ID = block_ID

	return new_block


func build_data(var definition):

	var new_block = DataBlock.instance()
	new_block.build(definition.data_type)

	new_block.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
	
	for component in definition.components:
	
		if component.type != BlockHandler.Components.OPENING:
			if component.type != BlockHandler.Components.TEXT:
				var new_component = new_block.add_component(component)
				new_block.component_dict[component.name] = new_component
				new_component.parent_block = new_block
			else:
				new_block.add_component(component)

	return new_block




func build_statement(var definition):

	var new_block = StatementBlock.instance()

	var new_part = null

	if definition.block_type == BlockTypes.HEADER:
		new_part = BlockHandler.StatementHead.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
		new_block.get_node("Parts").add_child(new_part)
	else:
		new_part = BlockHandler.StatementTop.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
		new_block.get_node("Parts").add_child(new_part)

	var current_middle = null

	for component in definition.components:

		if component.type != BlockHandler.Components.OPENING:
			if current_middle == null:
				current_middle = BlockHandler.StatementMiddle.instance()
				current_middle.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
				new_block.get_node("Parts").add_child(current_middle)

			if component.type != BlockHandler.Components.TEXT:
				var new_component = current_middle.add_component(component)
				new_block.component_dict[component.name] = new_component
				new_component.parent_block = new_block
			else:
				current_middle.add_component(component)
		else:
			var new_component = BlockHandler.OpeningComponent.instance()
			new_component.parent_block = new_block
			new_block.get_node("Parts").add_child(new_component)
			new_block.component_dict[component.name] = new_component
			new_component.set_color(EditorHandler.CATEGORY_COLORS[definition.category])
			current_middle = null

	if definition.block_type == BlockTypes.END:
		new_part = BlockHandler.StatementEnd.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
		new_block.get_node("Parts").add_child(new_part)
	else:
		new_part = BlockHandler.StatementBottom.instance()
		new_part.self_modulate = EditorHandler.CATEGORY_COLORS[definition.category]
		new_block.get_node("Parts").add_child(new_part)

	return new_block





