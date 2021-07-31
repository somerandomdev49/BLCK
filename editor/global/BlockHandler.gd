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
const NumInputStyle = preload("res://assets/editor/blocks/components/input_styles/NumInput.tres")
const BoolInputStyle = preload("res://assets/editor/blocks/components/input_styles/BoolInput.tres")
const StringInputStyle = preload("res://assets/editor/blocks/components/input_styles/StringInput.tres")
const SpecialInputStyle = preload("res://assets/editor/blocks/components/input_styles/SpecialInput.tres")
const UniversalInputStyle = preload("res://assets/editor/blocks/components/input_styles/UniversalInput.tres")

#BlockStyles
const NumBlockStyle = preload("res://assets/editor/blocks/data/styles/NumBlock.tres")
const BoolBlockStyle = preload("res://assets/editor/blocks/data/styles/BoolBlock.tres")
const StringBlockStyle = preload("res://assets/editor/blocks/data/styles/StringBlock.tres")
const SpecialBlockStyle = preload("res://assets/editor/blocks/data/styles/SpecialBlock.tres")


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
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@counter": {
		"icon": CounterIcon,
		"input": SpecialInputs.NUMBER,
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@group": {
		"icon": GroupIcon,
		"input": SpecialInputs.NUMBER,
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@color": {
		"icon": ColorIcon,
		"input": SpecialInputs.NUMBER,
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@block": {
		"icon": BlockIcon,
		"input": SpecialInputs.NUMBER,
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@item": {
		"icon": ItemIcon,
		"input": SpecialInputs.NUMBER,
		"input_style": NumInputStyle,
		"block_style": NumBlockStyle,
	},
	"@string": {
		"icon": null,
		"input": SpecialInputs.STRING,
		"input_style": StringInputStyle,
		"block_style": StringBlockStyle,
	},
	"@boolean": {
		"icon": null,
		"input": SpecialInputs.BOOLEAN,
		"input_style": BoolInputStyle,
		"block_style": BoolBlockStyle,
	},
	"@object": {
		"icon": ObjectIcon,
		"input": null,
		"input_style": SpecialInputStyle,
		"block_style": SpecialBlockStyle,
	},
	"@dict": {
		"icon": DictIcon,
		"input": null,
		"input_style": SpecialInputStyle,
		"block_style": SpecialBlockStyle,
	},
	"@array": {
		"icon": ArrayIcon,
		"input": null,
		"input_style": SpecialInputStyle,
		"block_style": SpecialBlockStyle,
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

	####Control
	#--------------------------------
	"IF": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.CONTROL,
		"components": [
			text("if"),
			data(["@boolean"],"condition"),
			opening("true"),
		]
	},
	"IF_ELSE": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.CONTROL,
		"components": [
			text("if"),
			data(["@boolean"],"condition"),
			opening("true"),
			text("else"),
			opening("false"),
		]
	},
	"REPEAT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.CONTROL,
		"components": [
			text("repeat"),
			data(["@number"],"amount"),
			opening("blocks"),
		]
	},

	####Group
	#--------------------------------

	"MOVE_INSTANT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group"),
			text("x:"), data(["@number"],"x"),
			text("y:"), data(["@number"],"y"),
		]
	},
	"MOVE_DURATION": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group"),
			text("x:"), data(["@number"],"x"),
			text("y:"), data(["@number"],"y"),
			text("over"), data(["@number"],"time"), text("seconds")
		]
	},
	"MOVE_FULL": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group"),
			text("x:"), data(["@number"],"x"),
			text("y:"), data(["@number"],"y"),
			text("over"), data(["@number"],"time"),
			text("seconds, easing:"),
			list([
				"Ease In Out",
				"Ease In",
				"Ease Out",
				"Elastic In Out",
				"Elastic In",
				"Elastic Out",
				"Bounce In Out",
				"Bounce In",
				"Bounce Out",
				"Exponential In Out",
				"Exponential In",
				"Exponential Out",
				"Sine In Out",
				"Sine In",
				"Sine Out",
				"Back In Out",
				"Back In",
				"Back Out",
			], "easing"),
			text("rate:"), data(["@number"],"rate"),
		]
	},
	"ALPHA": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("set alpha of"),
			data(["@group"],"group"),
			text("to"), data(["@number"],"amount"), text("%")
		]
	},
	"ALPHA_DURATION": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("set alpha of"),
			data(["@group"],"group"),
			text("to"), data(["@number"],"amount"), text("%"),
			text("over"), data(["@number"],"time"), text("seconds")
		]
	},
	"FOLLOW": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("make"), data(["@group"],"group1"),
			text("follow"), data(["@group"],"group2"),
			text("for"), data(["@number"],"time"), text("seconds")
		]
	},
	"FOLLOW_FULL": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("make"), data(["@group"],"group1"),
			text("follow"), data(["@group"],"group2"),
			text("for"), data(["@number"],"time"), text("seconds"),
			text("x mod:"), data(["@number"],"x_mod"),
			text("y mod:"), data(["@number"],"y_mod"),
		]
	},
	"FOLLOW_Y": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("make"), data(["@group"],"group"),
			text("follow the player's Y for"),
			data(["@number"],"time"), text("seconds")
		]
	},
	"FOLLOW_Y_FULL": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("make"), data(["@group"],"group"),
			text("follow the player's Y for"),
			data(["@number"],"time"), text("seconds, delay:"),
			data(["@number"],"delay"),
			text("offset:"), data(["@number"],"offset"),
			text("max speed:"), data(["@number"],"max_speed"),
		]
	},
	"LOCK_TO_PLAYER_X": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("lock"), data(["@group"],"group"),
			text("to the player's X for"),
			data(["@number"],"time"), text("seconds"),
		]
	},
	"LOCK_TO_PLAYER_Y": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("lock"), data(["@group"],"group"),
			text("to the player's Y for"),
			data(["@number"],"time"), text("seconds"),
		]
	},
	"LOCK_TO_PLAYER": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("lock"), data(["@group"],"group"),
			text("to the player for"),
			data(["@number"],"time"), text("seconds"),
		]
	},
	"MOVE_TO_INSTANT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group1"),
			text("to"), data(["@group"],"group2"),
		]
	},
	"MOVE_TO_DURATION": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group1"),
			text("to"), data(["@group"],"group2"),
			text("over"), data(["@number"],"time"), text("seconds")
		]
	},
	"MOVE_TO_FULL": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("move"), data(["@group"],"group1"),
			text("to"), data(["@group"],"group2"),
			text("over"), data(["@number"],"time"),
			text("seconds, easing:"),
			list([
				"Ease In Out",
				"Ease In",
				"Ease Out",
				"Elastic In Out",
				"Elastic In",
				"Elastic Out",
				"Bounce In Out",
				"Bounce In",
				"Bounce Out",
				"Exponential In Out",
				"Exponential In",
				"Exponential Out",
				"Sine In Out",
				"Sine In",
				"Sine Out",
				"Back In Out",
				"Back In",
				"Back Out",
			], "easing"),
			text("rate:"), data(["@number"],"rate"),
		]
	},
	"ROTATE_INSTANT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("rotate"), data(["@group"],"group1"),
			data(["@number"],"degrees"), text("degrees around"),
			data(["@group"],"group2"),
			text("lock rotation?"), data(["@boolean"],"lock"),
		]
	},
	"ROTATE_DURATION": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("rotate"), data(["@group"],"group1"),
			data(["@number"],"degrees"), text("degrees around"),
			data(["@group"],"group2"),
			text("over"), data(["@number"],"time"),
			text("seconds, lock rotation?"), data(["@boolean"],"lock"),
		]
	},
	"ROTATE_FULL": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("rotate"), data(["@group"],"group1"),
			data(["@number"],"degrees"), text("degrees around"),
			data(["@group"],"group2"),
			text("over"), data(["@number"],"time"),
			text("seconds, easing:"),
			list([
				"Ease In Out",
				"Ease In",
				"Ease Out",
				"Elastic In Out",
				"Elastic In",
				"Elastic Out",
				"Bounce In Out",
				"Bounce In",
				"Bounce Out",
				"Exponential In Out",
				"Exponential In",
				"Exponential Out",
				"Sine In Out",
				"Sine In",
				"Sine Out",
				"Back In Out",
				"Back In",
				"Back Out",
			], "easing"),
			text("rate:"), data(["@number"],"rate"),
			text("lock rotation?"), data(["@boolean"],"lock"),
		]
	},
	"TOGGLE_OFF": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("toggle"), data(["@group"],"group"), text("off"),
		]
	},
	"TOGGLE_ON": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("toggle"), data(["@group"],"group"), text("on"),
		]
	},
	"PULSE_GROUP": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("pulse"), data(["@group"],"group"), picker(false,"color"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},
	"PULSE_GROUP_RGB": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("pulse"), data(["@group"],"group"),
			text("r:"), data(["@number"],"r"),
			text("g:"), data(["@number"],"g"),
			text("b:"), data(["@number"],"b"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},
	"PULSE_GROUP_HSV": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.GROUPS,
		"components": [
			text("pulse"), data(["@group"],"group"),
			text("h:"), data(["@number"],"h"),
			text("s:"), data(["@number"],"s"), data(["@boolean"],"s_checked"),
			text("v:"), data(["@number"],"v"), data(["@boolean"],"v_checked"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},

	####Colors
	#--------------------------------
	
	"PULSE_COLOR": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COLORS,
		"components": [
			text("pulse"), data(["@color"],"channel"), picker(false,"color"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},
	"PULSE_COLOR_RGB": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COLORS,
		"components": [
			text("pulse"), data(["@color"],"channel"),
			text("r:"), data(["@number"],"r"),
			text("g:"), data(["@number"],"g"),
			text("b:"), data(["@number"],"b"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},
	"PULSE_COLOR_HSV": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COLORS,
		"components": [
			text("pulse"), data(["@color"],"channel"),
			text("h:"), data(["@number"],"h"),
			text("s:"), data(["@number"],"s"), data(["@boolean"],"s_checked"),
			text("v:"), data(["@number"],"v"), data(["@boolean"],"v_checked"),
			text("fade in:"), data(["@number"],"fade_in"),
			text("hold:"), data(["@number"],"hold"),
			text("fade out:"), data(["@number"],"fade_out"),
			text("exclusive?"), data(["@boolean"],"exclusive"),
		]
	},
	"SET_COLOR": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COLORS,
		"components": [
			text("set"), data(["@color"],"channel"),
			text("to"), picker(false,"color"),
			text("over"), data(["@number"],"time"),
			text("seconds, blending?"), data(["@boolean"],"blending"),
		]
	},
	"SET_COLOR_RGBA": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COLORS,
		"components": [
			text("set"), data(["@color"],"channel"),
			text("r:"), data(["@number"],"r"),
			text("g:"), data(["@number"],"g"),
			text("b:"), data(["@number"],"b"),
			text("a:"), data(["@number"],"opacity"),
			text("over"), data(["@number"],"time"),
			text("seconds, blending?"), data(["@boolean"],"blending"),
		]
	},
	####Blocks
	#--------------------------------
	"TRACKER_COUNTER": {
		"block_type": BlockTypes.DATA,
		"data_type": "@counter",
		"category": EditorHandler.Categories.BLOCKS,
		"components": [
			text("tracker counter for"),
			data(["@block"],"block1"),
			text("and"), data(["@block"],"block2"),
		]
	},
	
	####Counters
	#--------------------------------
	"COUNTER_ADD": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COUNTERS,
		"components": [
			text("add"), data(["@number"], "value"),
			text("to"), data(["@counter"], "counter"),
		]
	},
	"COUNTER_SUBTRACT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COUNTERS,
		"components": [
			text("subtract"), data(["@number"], "value"),
			text("from"), data(["@counter"], "counter"),
		]
	},
	"COUNTER_MULTIPLY": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COUNTERS,
		"components": [
			text("multiply"), data(["@counter"], "counter"),
			text("by"), data(["@number"], "value"),
		]
	},
	"COUNTER_DIVIDE": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COUNTERS,
		"components": [
			text("divide"), data(["@counter"], "counter"),
			text("by"), data(["@number"], "value"),
		]
	},
	"COUNTER_ASSIGN": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.COUNTERS,
		"components": [
			text("set"), data(["@counter"], "counter"),
			text("to"), data(["@number"], "value"),
		]
	},

	####Strings
	#--------------------------------
	"STRING_JOIN": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("join"), data(["@string"], "string1"),
			data(["@string"], "string2"),
		]
	},
	"STRING_CHAR": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("character"), data(["@number"], "i"),
			text("of"), data(["@string"], "string"),
		]
	},
	"STRING_LENGTH": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("length of"), data(["@string"], "string"),
		]
	},
	"STRING_CONTAINS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			data(["@string"], "string1"),
			text("contains"),
			data(["@string"], "string2"),
		]
	},
	"STRING_STARTS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			data(["@string"], "string1"),
			text("starts with"),
			data(["@string"], "string2"),
		]
	},
	"STRING_ENDS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			data(["@string"], "string1"),
			text("ends with"),
			data(["@string"], "string2"),
		]
	},
	"STRING_INDEX": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("position of"),
			data(["@string"], "string1"),
			text("in"),
			data(["@string"], "string2"),
		]
	},
	"STRING_IS_EMPTY": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("is"),
			data(["@string"], "string"),
			text("empty"),
		]
	},
	"STRING_IS_LOWERCASE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("is"),
			data(["@string"], "string"),
			text("lowercase"),
		]
	},
	"STRING_IS_UPPERCASE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("is"),
			data(["@string"], "string"),
			text("uppercase"),
		]
	},
	"STRING_LOWERCASE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("make"), data(["@string"], "string"),
			text("lowercase"),
		]
	},
	"STRING_UPPERCASE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("make"), data(["@string"], "string"),
			text("uppercase"),
		]
	},
	"STRING_INTERLACE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("interlace"), data(["@string"], "string"),
			text("in"), data(["@array"], "array"),
		]
	},
	"STRING_SPLIT": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("split"), data(["@string"], "string"),
			text("with"), data(["@string"], "separator"),
		]
	},
	"STRING_REVERSE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("reverse"), data(["@string"], "string"),
		]
	},
	"SUBSTRING": {
		"block_type": BlockTypes.DATA,
		"data_type": "@string",
		"category": EditorHandler.Categories.STRINGS,
		"components": [
			text("part of"), data(["@string"], "string"),
			text("from"), data(["@number"], "a"),
			text("to"), data(["@number"], "b"),
		]
	},

	####Arrays
	#--------------------------------
	"CLEAR_ARRAY": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("clear"), data(["@array"], "array"),
		]
	},
	"ARRAY_CONTAINS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			data(["@array"], "array"),
			text("contains"),
			data([], "element"),
		]
	},
	"ARRAY_INDEX": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("position of"),
			data([], "element"),
			text("in"),
			data(["@array"], "array"),
		]
	},
	"ARRAY_EMPTY": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("is"),
			data(["@array"], "array"),
			text("empty"),
		]
	},
	"ARRAY_MAX": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("max number in"),
			data(["@array"], "array"),
		]
	},
	"ARRAY_MIN": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("min number in"),
			data(["@array"], "array"),
		]
	},
	"ARRAY_POP": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("remove last element from"),
			data(["@array"], "array"),
		]
	},
	"ARRAY_PUSH": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("add"), data([], "element"),
			text("to"), data(["@array"], "array"),
		]
	},
	"ARRAY_REVERSE": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("reverse"), data(["@array"], "array"),
		]
	},
	"ARRAY_SORTED": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			data(["@array"], "array"), text("sorted"),
		]
	},
	"ARRAY_SHIFT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("remove first element from"),
			data(["@array"], "array"),
		]
	},
	"ARRAY_REMOVE": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("remove element at position"), data(["@number"],"pos"),
			text("from"), data(["@array"], "array"),
		]
	},
	"ARRAY_UNSHIFT": {
		"block_type": BlockTypes.STATEMENT,
		"data_type": "",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("add"), data([], "element"),
			text("to the start of"), data(["@array"], "array"),
		]
	},
	"ARRAY_SUM": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("sum of numbers in"),
			data(["@array"], "array"),
		]
	},
	"RANGE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("range from"), data(["@number"],"start"),
			text("to"), data(["@number"],"end"),
		]
	},
	"RANGE_STEP": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			text("range from"), data(["@number"],"start"),
			text("to"), data(["@number"],"end"),
			text("with step"), data(["@number"],"step"),
		]
	},
	"TYPE_RANGE": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			list(["group","color","block","item"],"type"),
			text("range from"), data(["@number"],"start"),
			text("to"), data(["@number"],"end"),
		]
	},
	"TYPE_RANGE_STEP": {
		"block_type": BlockTypes.DATA,
		"data_type": "@array",
		"category": EditorHandler.Categories.ARRAYS,
		"components": [
			list(["group","color","block","item"],"type"),
			text("range from"), data(["@number"],"start"),
			text("to"), data(["@number"],"end"),
			text("with step"), data(["@number"],"step"),
		]
	},


	####Operators
	#--------------------------------
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
	"MULT": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("*"),
			data(["@number"], "b"),
		]
	},
	"DIV": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("/"),
			data(["@number"], "b"),
		]
	},
	"MOD": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("%"),
			data(["@number"], "b"),
		]
	},
	"POW": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("^"),
			data(["@number"], "b"),
		]
	},
	"ABS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			text("abs"),
			data(["@number"], "x"),
		]
	},
	"TRIG": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			list(["sin","cos","tan","asin","acos","atan"],"function"),
			data(["@number"], "x"),
		]
	},
	"ROUND": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			list(["round","floor","ceil"],"function"),
			data(["@number"], "x"),
		]
	},
	"EULER": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			list(["e^","ln"],"function"),
			data(["@number"], "x"),
		]
	},
	"SQRT": {
		"block_type": BlockTypes.DATA,
		"data_type": "@number",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			text("sqrt"),
			data(["@number"], "x"),
		]
	},

	"NOT": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			text("not"),
			data(["@boolean"], "a"),
		]
	},
	"AND": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@boolean"], "a"),
			text("and"),
			data(["@boolean"], "b"),
		]
	},
	"OR": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@boolean"], "a"),
			text("or"),
			data(["@boolean"], "b"),
		]
	},
	"XOR": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@boolean"], "a"),
			text("xor"),
			data(["@boolean"], "b"),
		]
	},

	"EQUALS": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("="),
			data(["@number"], "b"),
		]
	},
	"GREATER": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text(">"),
			data(["@number"], "b"),
		]
	},
	"LESSER": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("<"),
			data(["@number"], "b"),
		]
	},
	"GREATER_EQ": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("≥"),
			data(["@number"], "b"),
		]
	},
	"LESSER_EQ": {
		"block_type": BlockTypes.DATA,
		"data_type": "@boolean",
		"category": EditorHandler.Categories.OPERATORS,
		"components": [
			data(["@number"], "a"),
			text("≤"),
			data(["@number"], "b"),
		]
	},
	
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





