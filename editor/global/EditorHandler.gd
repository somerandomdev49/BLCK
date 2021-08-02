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
	EVENTS,
	VARIABLES,
	DEBUG,
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
	Categories.EVENTS: Color("B76D38"),
	Categories.VARIABLES: Color("FF8038"),
	Categories.DEBUG: Color("444444"),
}

const CATEGORY_NAMES = {
	Categories.OPERATORS: "Operators",
	Categories.GROUPS: "Groups",
	Categories.COUNTERS: "Counters",
	Categories.COLORS: "Colors",
	Categories.BLOCKS: "Block",
	Categories.STRINGS: "Strings",
	Categories.ARRAYS: "Arrays",
	Categories.OBJECTS: "Objects",
	Categories.CONTROL: "Control",
	Categories.EVENTS: "Events",
	Categories.VARIABLES: "Variables",
	Categories.DEBUG: "Debug",
}



func _ready():
	pass
