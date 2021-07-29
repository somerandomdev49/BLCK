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

const StringBlock = preload("res://editor/blocks/string/StringBlock.tscn")

const BooleanBlock = preload("res://editor/blocks/boolean/BooleanBlock.tscn")

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
	
	for i in BLOCK_DEFINITIONS:
		BLOCK_DEFINITIONS_PARSED[i] = parseDef(BLOCK_DEFINITIONS[i])
	
	

const BLOCK_DEFINITIONS = {
   "IF": "statement|control|if %bool(condition) %open(true)",
   "IF_ELSE": "statement|control|if %bool(condition) %open(true) else %open(false)",
   "FOR_IN": "statement|control|if %bool(condition) %open(true) else %open(false)",
   "WHILE": "statement|control|while %bool(condition) %open(blocks)",
   "REPEAT": "statement|control|repeat %n(amount) times %open(blocks)",
   "MOVE_INSTANT": "statement|groups|move %g(group) x: %n(x) y: %n(y)",
   "MOVE_DURATION": "statement|groups|move %g(group) x: %n(x) y: %n(y) over %n(time) seconds",
   "MOVE_FULL": "statement|groups|move %g(group) x: %n(x) y: %n(y) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate)",
   "ALPHA": "statement|groups|set alpha of %g(group) to %n(amount) `%",
   "FOLLOW": "statement|groups|make %g(group1) follow %g(group2) for %n(time) seconds",
   "FOLLOW_FULL": "statement|groups|make %g(group1) follow %g(group2) for %n(time) seconds, x mod: %n(x_mod) y mod: %n(y_mod)",
   "FOLLOW_Y": "statement|groups|make %g(group1) follow the player's Y for %n(time) seconds",
   "FOLLOW_Y_DELAY": "statement|groups|make %g(group1) follow the player's Y for %n(time) seconds with a %n(delay) second delay, offset: %n(offset) max speed: %n(max_speed)",
   "LOCK_TO_PLAYER_X": "statement|groups|lock %g(group1) to the player's X for %n(time) seconds",
   "LOCK_TO_PLAYER_Y": "statement|groups|lock %g(group1) to the player's Y for %n(time) seconds",
   "LOCK_TO_PLAYER": "statement|groups|lock %g(group1) to the player for %n(time) seconds",
   "MOVE_TO_INSTANT": "statement|groups|move %g(group1) to %g(group2)",
   "MOVE_TO_DURATION": "statement|groups|move %g(group1) to %g(group2) over %n(time) seconds",
   "MOVE_TO_FULL": "statement|groups|move %g(group1) to %g(group2) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate)",
   "ROTATE_INSTANT": "statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) (lock rotation? %bool(lock))",
   "ROTATE_DURATION": "statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) over %n(time) seconds (lock rotation? %bool(lock))",
   "ROTATE_FULL": "statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate) (lock rotation? %bool(lock))",
   "TOGGLE_OFF": "statement|groups|toggle %g(group) off",
   "TOGGLE_ON": "statement|groups|toggle %g(group) on",
   "PULSE_GROUP": "statement|groups|pulse %g(group) %pick(color) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "PULSE_GROUP_RGB": "statement|groups|pulse %g(group) r: %n(r) g: %n(g) b: %n(b) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "PULSE_GROUP_HSV": "statement|groups|pulse %g(group) h: %n(r) s: %n(g) %bool(s_checked) v: %n(b) %bool(v_checked) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "PULSE_COLOR": "statement|colors|pulse %c(channel) %pick(color) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "PULSE_COLOR_RGB": "statement|colors|pulse %c(channel) r: %n(r) g: %n(g) b: %n(b) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "PULSE_COLOR_HSV": "statement|colors|pulse %c(channel) h: %n(r) s: %n(g) %bool(s_checked) v: %n(b) %bool(v_checked) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
   "SET_COLOR": "statement|colors|set %c(channel) to %pick(color) over %n(time) seconds, blending? %bool(blending)",
   "SET_COLOR_RGBA": "statement|colors|set %c(channel) to r: %n(r) g: %n(g) b: %n(b) a: %n(opacity) over %n(time) seconds, blending? %bool(blending)",
   "TRACKER_COUNTER": "counter|blocks|tracker counter for %b(a) and %b(b)",
   "ADD": "statement|counters|add %n(value) to %#(counter)",
   "SUBTRACT": "statement|counters|subtract %n(value) from %#(counter)",
   "MULTIPLY": "statement|counters|multiply %#(counter) by %n(value)",
   "DIVIDE": "statement|counters|divide %#(counter) by %n(value)",
   "ASSIGN": "statement|counters|set %#(counter) to %n(value)",
   "JOIN": "string|strings|join %str(a) %str(b)",
   "LETTER": "string|strings|letter %n(i) of %str(text)",
   "LENGTH": "string|strings|length of %str(text)",
   "STRING_CONTAINS": "boolean|strings|%str(text1) contains %str(text2)",
   "STRING_STARTS": "boolean|strings|%str(text1) starts with %str(text2)",
   "STRING_ENDS": "boolean|strings|%str(text1) ends with %str(text2)",
   "STRING_INDEX": "number|strings|position of %str(text2) in %str(text2)",
   "STRING_IS_EMPTY": "boolean|strings|is %str(text) empty",
   "STRING_IS_LOWERCASE": "boolean|strings|is %str(text) lowercase",
   "STRING_IS_UPPERCASE": "boolean|strings|is %str(text) uppercase",
   "STRING_INTERLACE": "string|strings|interlace %str(text) in %arr(array)",
   "STRING_LOWERCASE": "string|strings|make %str(text) lowercase",
   "STRING_UPPERCASE": "string|strings|make %str(text) uppercase",
   "STRING_REVERSE": "string|strings|reverse %str(text)",
   "STRING_SPLIT": "array|strings|split %str(text) with %str(separator)",
   "SUBSTRING": "string|strings|part of %str(text) from %n(a) to %n(b)",
   "CLEAR_ARRAY": "statement|arrays|clear %arr(array)",
   "ARRAY_CONTAINS": "boolean|arrays|%arr(array) contains %any(el)",
   "ARRAY_INDEX": "number|arrays|position of %any(el) in %arr(array)",
   "ARRAY_EMPTY": "boolean|arrays|is %arr(array) empty",
   "ARRAY_MAX": "number|arrays|max number in %arr(array)",
   "ARRAY_MIN": "number|arrays|min number in %arr(array)",
   "ARRAY_POP": "statement|arrays|remove last element from %arr(array)",
   "ARRAY_SHIFT": "statement|arrays|remove first element from %arr(array)",
   "ARRAY_REMOVE": "statement|arrays|remove element at position %n(pos) from %arr(array)",
   "ARRAY_PUSH": "statement|arrays|add %any(el) to %arr(array)",
   "ARRAY_REVERSE": "statement|arrays|reverse %arr(array)",
   "ARRAY_SORT": "array|arrays|sort %arr(array)",
   "ARRAY_SUM": "number|arrays|sum of numbers in %arr(array)",
   "ARRAY_UNSHIFT": "statement|arrays|add %any(el) to the start of %arr(array)",
   "RANGE": "array|arrays|range from %n(start) to %n(end)",
   "RANGE_STEP": "array|arrays|range from %n(start) to %n(end) with step %n(step)",
   "TYPE_RANGE": "array|arrays|%list(type)[group,color,block,item] range from %n(start) to %n(end)",
   "TYPE_RANGE_STEP": "array|arrays|%list(type)[group,color,block,item] range from %n(start) to %n(end) with step %n(step)",
   "OBJECT_ADD": "statement|objects|add %obj(object) to level",
   "OBJECT_SET": "statement|objects|set key %str(key) of %obj(object) to %any(value)",
   "PLUS": "number|operators|%n(a) + %n(b)",
   "MINUS": "number|operators|%n(a) - %n(b)",
   "MULT": "number|operators|%n(a) * %n(b)",
   "DIV": "number|operators|%n(a) / %n(b)",
   "MOD": "number|operators|%n(a) `% %n(b)",
   "POW": "number|operators|%n(a) ^ %n(b)",
   "ABS": "number|operators|abs %n(x)",
   "TRIG": "number|operators|%list(op)[sin,cos,tan,asin,acos,atan] %n(x)",
   "ROUND": "number|operators|%list(op)[round,floor,ceil] %n(x)",
   "EULER": "number|operators|%list(op)[e^,ln] %n(x)",
   "SQRT": "number|operators|sqrt %n(x)",
   "NOT": "boolean|operators|not %bool(a)",
   "AND": "boolean|operators|%bool(a) and %bool(b)",
   "OR": "boolean|operators|%bool(a) or %bool(b)",
   "XOR": "boolean|operators|%bool(a) xor %bool(b)",
   "EQUALS": "boolean|operators|%n(a) = %n(b)",
   "GREATER": "boolean|operators|%n(a) > %n(b)",
   "LESSER": "boolean|operators|%n(a) < %n(b)",
   "GREATER_EQ": "boolean|operators|%n(a) ≥ %n(b)",
   "LESSER_EQ": "boolean|operators|%n(a) ≤ %n(b)"
}

const BLOCK_DEFINITIONS_PARSED = {
		
}

func buildBlock(var block_ID):
	
	var definition = BLOCK_DEFINITIONS_PARSED[block_ID]
	
	var new_block = null
	
	match definition.block_type:
		BlockTypes.STATEMENT:
			new_block = buildStatement(definition.components,definition.block_type,definition.category)
		BlockTypes.HEADER:
			new_block = buildStatement(definition.components,definition.block_type,definition.category)
		BlockTypes.END:
			new_block = buildStatement(definition.components,definition.block_type,definition.category)
		_:
			new_block = buildData(definition.components,definition.block_type,definition.category)
	
	new_block.block_ID = block_ID
	
	return new_block
	

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
	




