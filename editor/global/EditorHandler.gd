extends Node


enum Categories{
	OPERATORS,
	GROUPS,
	COUNTERS,
	COLORS,
	BLOCKS,
	STRINGS,
	ARRAYS,
	OBJECTS,
	CONTROL,
}

const CATEGORY_COLORS = {
	Categories.OPERATORS: Color(0.356, 0.89, 0.4628),
	Categories.GROUPS: Color("D16B4A"),
	Categories.COUNTERS: Color("4C78E8"),
	Categories.COLORS: Color("4CA4E3"),
	Categories.BLOCKS: Color("A6ADB1"),
	Categories.STRINGS: Color(0.1672, 0.76, 0.58216),
	Categories.ARRAYS: Color("7250D1"),
	Categories.OBJECTS: Color("9C4444"),
	Categories.CONTROL: Color("EAA656"),
}

const CATEGORY_NAMES = {
	"operators": Categories.OPERATORS,
	"groups": Categories.GROUPS,
	"counters": Categories.COUNTERS,
	"colors": Categories.COLORS,
	"blocks": Categories.BLOCKS,
	"strings": Categories.STRINGS,
	"arrays": Categories.ARRAYS,
	"objects": Categories.OBJECTS,
	"control": Categories.CONTROL,
}



func _ready():
	pass
