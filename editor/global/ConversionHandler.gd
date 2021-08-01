extends Node

func format(var string, var comp):

	var arr = string.split('`')
	for i in arr.size():
		if i % 2 == 1:
			arr[i] = comp[arr[i]]
	var output = ""
	for i in arr:
		output += i
	return output


func convert_component(var input):
	
	var connected_block = null
	
	if input.is_in_group("can_connect"):
		connected_block = input.get_connected_block()
	
	if connected_block != null:
		if input.is_in_group("opening"):
			return convert_block(connected_block,true)
		else:
			return convert_block(connected_block)
	else:
		return input.empty_convert()

const INIT_STRING = """

xor = (a: @bool, b: @bool) {
	return (a || b) && !(a && b)
}

"""

func convert_block(var block, var tabbed = false):
	
	var block_ID = block.block_ID
	var comp = {}
	
	for i in block.component_dict:
		comp[i] = convert_component( block.component_dict[i] )
	
	var result = ""
	
	match block_ID:
		"IF":
			result = format("if (`condition`) {\n`true`\n}", comp )
		"IF_ELSE":
			result = format("if (`condition`) {\n`true`\n} else {\n`false`\n}", comp )
		"REPEAT":
			result = format("for i in 0..`amount` {\n`blocks`\n}", comp )
		"MOVE_INSTANT":
			result = format("`group`.move(`x`,`y`)", comp )
		"MOVE_DURATION":
			result = format("`group`.move(`x`,`y`,duration=`time`)", comp )
		"MOVE_FULL":
			var easing = comp["easing"].to_upper().replace(" ","_")
			result = format("`group`.move(`x`,`y`,duration=`time`,easing=" + easing + ",rate=`rate`)", comp )
		"ALPHA":
			var alpha = float(comp["amount"]) / 100.0
			result = format("`group`.alpha(" + str(alpha) + ")", comp )
		"ALPHA_DURATION":
			var alpha = float(comp["amount"]) / 100.0
			result = format("`group`.alpha(" + str(alpha) + ",duration=`time`)", comp )
		"FOLLOW":
			result = format("`group1`.follow(`group2`,duration=`time`)", comp )
		"FOLLOW_FULL":
			result = format("`group1`.follow(`group2`,duration=`time`,x_mod=`x_mod`,y_mod=`y_mod`)", comp )
		"FOLLOW_Y":
			result = format("`group`.follow_player_y(duration=`time`)", comp )
		"FOLLOW_Y_FULL":
			result = format("`group`.follow_player_y(delay=`delay`,max_speed=`max_speed`,offset=`offset`,speed=`speed`,duration=`time`)", comp )
		"LOCK_TO_PLAYER_X":
			result = format("`group`.lock_to_player(lock_x=true,duration=`time`)", comp )
		"LOCK_TO_PLAYER_Y":
			result = format("`group`.lock_to_player(lock_y=true,duration=`time`)", comp )
		"LOCK_TO_PLAYER":
			result = format("`group`.lock_to_player(duration=`time`)", comp )
		"MOVE_TO_INSTANT":
			match comp["coords"]:
				"on X and Y":
					result = format("`group1`.move_to(`group2`)", comp )
				"on X":
					result = format("`group1`.move_to(`group2`,x_only=true)", comp )
				"on Y":
					result = format("`group1`.move_to(`group2`,y_only=true)", comp )
		"MOVE_TO_DURATION":
			match comp["coords"]:
				"on X and Y":
					result = format("`group1`.move_to(`group2`,duration=`time`)", comp )
				"on X":
					result = format("`group1`.move_to(`group2`,x_only=true,duration=`time`)", comp )
				"on Y":
					result = format("`group1`.move_to(`group2`,y_only=true,duration=`time`)", comp )
		"MOVE_TO_FULL":
			var easing = comp["easing"].to_upper().replace(" ","_")
			match comp["coords"]:
				"on X and Y":
					result = format("`group1`.move_to(`group2`,duration=`time`,easing=" + easing + ",rate=`rate`)", comp )
				"on X":
					result = format("`group1`.move_to(`group2`,x_only=true,duration=`time`,easing=" + easing + ",rate=`rate`)", comp )
				"on Y":
					result = format("`group1`.move_to(`group2`,y_only=true,duration=`time`,easing=" + easing + ",rate=`rate`)", comp )
		"ROTATE_INSTANT":
			result = format("`group1`.rotate(`group2`,`degrees`,lock_object_rotation=`lock`)", comp )
		"ROTATE_DURATION":
			result = format("`group1`.rotate(`group2`,`degrees`,duration=`time`,lock_object_rotation=`lock`)", comp )
		"ROTATE_FULL":
			var easing = comp["easing"].to_upper().replace(" ","_")
			result = format("`group1`.rotate(`group2`,`degrees`,duration=`time`,lock_object_rotation=`lock`,easing=" + easing + ",rate=`rate`)", comp )
		"TOGGLE_OFF":
			result = format("`group`.toggle_off()", comp )
		"TOGGLE_ON":
			result = format("`group`.toggle_on()", comp )
		"PULSE_GROUP":
			var r = comp["color"].r8
			var g = comp["color"].g8
			var b = comp["color"].b8
			result = format("`group`.pulse("+str(r)+","+str(g)+","+str(g)+",fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,exclusive=`exclusive`)", comp )
		"PULSE_GROUP_RGB":
			result = format("`group`.pulse(`r`,`g`,`b`,fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,exclusive=`exclusive`)", comp )
		"PULSE_GROUP_HSV":
			result = format("`group`.pulse(`h`,`s`,`v`,s_checked=`s_checked`,b_checked=`v_checked`,fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,hsv=true,exclusive=`exclusive`)", comp )
		"PULSE_COLOR":
			var r = comp["color"].r8
			var g = comp["color"].g8
			var b = comp["color"].b8
			result = format("`channel`.pulse("+str(r)+","+str(g)+","+str(g)+",fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,exclusive=`exclusive`)", comp )
		"PULSE_COLOR_RGB":
			result = format("`channel`.pulse(`r`,`g`,`b`,fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,exclusive=`exclusive`)", comp )
		"PULSE_COLOR_HSV":
			result = format("`channel`.pulse(`h`,`s`,`v`,s_checked=`s_checked`,b_checked=`v_checked`,fade_in=`fade_in`,hold=`hold`,fade_out=`fade_out`,hsv=true,exclusive=`exclusive`)", comp )
		"SET_COLOR":
			var r = comp["color"].r8
			var g = comp["color"].g8
			var b = comp["color"].b8
			var a = comp["color"].a
			result = format("`channel`.set("+str(r)+","+str(g)+","+str(g)+",opacity="+str(a)+",duration=`time`,blending=`blending`)", comp )
		"SET_COLOR_RGBA":
			result = format("`channel`.set(`r`,`g`,`b`,opacity=`opacity`,duration=`time`,blending=`blending`)", comp )
		"TRACKER_COUNTER":
			result = format("counter(`block1`.create_tracker_item(`block2`))", comp )
		"COUNTER_ADD":
			result = format("`counter` += `value`", comp )
		"COUNTER_SUBTRACT":
			result = format("`counter` -= `value`", comp )
		"COUNTER_MULTIPLY":
			result = format("`counter` *= `value`", comp )
		"COUNTER_DIVIDE":
			result = format("`counter` /= `value`", comp )
		"COUNTER_PLUS":
			result = format("(`a` + `b`)", comp )
		"COUNTER_MINUS":
			result = format("(`a` - `b`)", comp )
		"COUNTER_MULT":
			result = format("(`a` * `b`)", comp )
		"COUNTER_DIV":
			result = format("(`a` / `b`)", comp )
		#"STRING_JOIN":
		"STRING_CHAR":
			result = format("`string`[`i`]", comp )
		"STRING_LENGTH":
			result = format("`string`.length", comp )
		"STRING_CONTAINS":
			result = format("`string1`.contains(`string2`)", comp )
		"STRING_STARTS":
			result = format("`string1`.starts_with(`string2`)", comp )
		"STRING_ENDS":
			result = format("`string1`.ends_with(`string2`)", comp )
		"STRING_INDEX":
			result = format("`string1`.index(`string2`)", comp )
		"STRING_IS_EMPTY":
			result = format("`string1`.is_empty()", comp )
#		"STRING_IS_LOWERCASE":
#			result = format("`string1`.is_lower()", comp )
#		"STRING_IS_UPPERCASE":
#			result = format("`string1`.is_uppercase()", comp )
#
		"CLEAR_ARRAY":
			result = format("`array`.clear()", comp )
		"ARRAY_CONTAINS":
			result = format("`array`.contains(`element`)", comp )
		"ARRAY_INDEX":
			result = format("`array`.index(`element`)", comp )
		"ARRAY_EMPTY":
			result = format("`array`.is_empty()", comp )
		"ARRAY_MAX":
			result = format("`array`.max()", comp )
		"ARRAY_MIN":
			result = format("`array`.min()", comp )
		"ARRAY_POP":
			result = format("`array`.pop()", comp )
		"ARRAY_PUSH":
			result = format("`array`.push(`element`)", comp )
		"ARRAY_REVERSE":
			result = format("`array`.reverse()", comp )
		"ARRAY_SORTED":
			result = format("`array`.sort()", comp )
		"ARRAY_SHIFT":
			result = format("`array`.shift()", comp )
		"ARRAY_REMOVE":
			result = format("`array`.remove(`pos`)", comp )
		"ARRAY_UNSHIFT":
			result = format("`array`.unshift(`element`)", comp )
		"ARRAY_SUM":
			result = format("`array`.sum()", comp )
		"RANGE":
			result = format("`start`..`end`", comp )
		"RANGE_STEP":
			result = format("`start`..`step`..`end`", comp )
		"TYPE_RANGE":
			match comp["type"]:
				"group":
					result = format("`start`g..`end`g", comp )
				"color":
					result = format("`start`c..`end`c", comp )
				"block":
					result = format("`start`b..`end`b", comp )
				"item":
					result = format("`start`i..`end`i", comp )
		
		
		"PLUS":
			result = format("(`a` + `b`)", comp )
		"MINUS":
			result = format("(`a` - `b`)", comp )
		"MULT":
			result = format("(`a` * `b`)", comp )
		"DIV":
			result = format("(`a` / `b`)", comp )
		"MOD":
			result = format("(`a` % `b`)", comp )
		"POW":
			result = format("(`a` ^ `b`)", comp )
		"ABS":
			result = format("$.abs(`x`)", comp )
		"TRIG":
			match comp["function"]:
				"sin":
					result = format("$.sin(`x`)", comp )
				"cos":
					result = format("$.cos(`x`)", comp )
				"tan":
					result = format("$.tan(`x`)", comp )
				"asin":
					result = format("$.asin(`x`)", comp )
				"acos":
					result = format("$.acos(`x`)", comp )
				"atan":
					result = format("$.atan(`x`)", comp )
		"ROUND":
			match comp["function"]:
				"round":
					result = format("$.round(`x`)", comp )
				"floor":
					result = format("$.floor(`x`)", comp )
				"ceil":
					result = format("$.ceil(`x`)", comp )
		"EULER":
			match comp["function"]:
				"e^":
					result = format("$.exp(`x`)", comp )
				"ln":
					result = format("$.ln(`x`)", comp )
		"SQRT":
			result = format("$.sqrt(`x`)", comp )
		"NOT":
			result = format("( !`a` )", comp )
		"AND":
			result = format("( `a` && `b` )", comp )
		"OR":
			result = format("( `a` || `b` )", comp )
		"XOR":
			result = format("xor(`a`, `b`)", comp )
		"EQUALS":
			result = format("( `a` == `b` )", comp )
		"GREATER":
			result = format("( `a` > `b` )", comp )
		"LESSER":
			result = format("( `a` < `b` )", comp )
		"GREATER_EQ":
			result = format("( `a` >= `b` )", comp )
		"LESSER_EQ":
			result = format("( `a` <= `b` )", comp )

	if block.is_in_group("statement_like"):
		var connected_block = block.get_connected_block()
		if connected_block != null:
			result += "\n" + convert_block(connected_block,false)
		if tabbed:
			result = "\t" + result.replace("\n","\n\t")
		return result
	else:
		return result
	
	
