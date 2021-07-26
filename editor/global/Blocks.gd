extends Node


const BLOCK_DEFINITIONS = {
   "IF":{
	  "def":"statement|control|if %bool(condition) %open(true)",
	  "code":""
   },
   "IF_ELSE":{
	  "def":"statement|control|if %bool(condition) %open(true) else %open(false)",
	  "code":""
   },
   "FOR_IN":{
	  "def":"statement|control|if %bool(condition) %open(true) else %open(false)",
	  "code":""
   },
   "WHILE":{
	  "def":"statement|control|while %bool(condition) %open(blocks)",
	  "code":""
   },
   "REPEAT":{
	  "def":"statement|control|repeat %n(amount) times %open(blocks)",
	  "code":""
   },
   "MOVE_INSTANT":{
	  "def":"statement|groups|move %g(group) x: %n(x) y: %n(y)",
	  "code":""
   },
   "MOVE_DURATION":{
	  "def":"statement|groups|move %g(group) x: %n(x) y: %n(y) over %n(time) seconds",
	  "code":""
   },
   "MOVE_FULL":{
	  "def":"statement|groups|move %g(group) x: %n(x) y: %n(y) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate)",
	  "code":""
   },
   "ALPHA":{
	  "def":"statement|groups|set alpha of %g(group) to %n(amount) `%",
	  "code":""
   },
   "FOLLOW":{
	  "def":"statement|groups|make %g(group1) follow %g(group2) for %n(time) seconds",
	  "code":""
   },
   "FOLLOW_FULL":{
	  "def":"statement|groups|make %g(group1) follow %g(group2) for %n(time) seconds, x mod: %n(x_mod) y mod: %n(y_mod)",
	  "code":""
   },
   "FOLLOW_Y":{
	  "def":"statement|groups|make %g(group1) follow the player's Y for %n(time) seconds",
	  "code":""
   },
   "FOLLOW_Y_DELAY":{
	  "def":"statement|groups|make %g(group1) follow the player's Y for %n(time) seconds with a %n(delay) second delay, offset: %n(offset) max speed: %n(max_speed)",
	  "code":""
   },
   "LOCK_TO_PLAYER_X":{
	  "def":"statement|groups|lock %g(group1) to the player's X for %n(time) seconds",
	  "code":""
   },
   "LOCK_TO_PLAYER_Y":{
	  "def":"statement|groups|lock %g(group1) to the player's Y for %n(time) seconds",
	  "code":""
   },
   "LOCK_TO_PLAYER":{
	  "def":"statement|groups|lock %g(group1) to the player for %n(time) seconds",
	  "code":""
   },
   "MOVE_TO_INSTANT":{
	  "def":"statement|groups|move %g(group1) to %g(group2)",
	  "code":""
   },
   "MOVE_TO_DURATION":{
	  "def":"statement|groups|move %g(group1) to %g(group2) over %n(time) seconds",
	  "code":""
   },
   "MOVE_TO_FULL":{
	  "def":"statement|groups|move %g(group1) to %g(group2) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate)",
	  "code":""
   },
   "ROTATE_INSTANT":{
	  "def":"statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) (lock rotation? %bool(lock))",
	  "code":""
   },
   "ROTATE_DURATION":{
	  "def":"statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) over %n(time) seconds (lock rotation? %bool(lock))",
	  "code":""
   },
   "ROTATE_FULL":{
	  "def":"statement|groups|rotate %g(group1) %n(degrees) degrees around %g(group2) over %n(time) seconds, easing: %list(easing)[Ease In Out, Ease In, Ease Out, Elastic In Out, Elastic In, Elastic Out, Bounce In Out, Bounce In, Bounce Out, Exponential In Out, Exponential In, Exponential Out, Sine In Out, Sine In, Sine Out, Back In Out, Back In, Back Out] rate: %n(rate) (lock rotation? %bool(lock))",
	  "code":""
   },
   "TOGGLE_OFF":{
	  "def":"statement|groups|toggle %g(group) off",
	  "code":""
   },
   "TOGGLE_ON":{
	  "def":"statement|groups|toggle %g(group) on",
	  "code":""
   },
   "PULSE_GROUP":{
	  "def":"statement|groups|pulse %g(group) %pick(color) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "PULSE_GROUP_RGB":{
	  "def":"statement|groups|pulse %g(group) r: %n(r) g: %n(g) b: %n(b) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "PULSE_GROUP_HSV":{
	  "def":"statement|groups|pulse %g(group) h: %n(r) s: %n(g) %bool(s_checked) v: %n(b) %bool(v_checked) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "PULSE_COLOR":{
	  "def":"statement|colors|pulse %c(channel) %pick(color) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "PULSE_COLOR_RGB":{
	  "def":"statement|colors|pulse %c(channel) r: %n(r) g: %n(g) b: %n(b) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "PULSE_COLOR_HSV":{
	  "def":"statement|colors|pulse %c(channel) h: %n(r) s: %n(g) %bool(s_checked) v: %n(b) %bool(v_checked) fade in: %n(fade_in) hold: %n(hold) fade out: %n(fade_out) exclusive? %bool(exclusive)",
	  "code":""
   },
   "SET_COLOR":{
	  "def":"statement|colors|set %c(channel) to %pick(color) over %n(time) seconds, blending? %bool(blending)",
	  "code":""
   },
   "SET_COLOR_RGBA":{
	  "def":"statement|colors|set %c(channel) to r: %n(r) g: %n(g) b: %n(b) a: %n(opacity) over %n(time) seconds, blending? %bool(blending)",
	  "code":""
   },
   "TRACKER_COUNTER":{
	  "def":"counter|blocks|tracker counter for %b(a) and %b(b)",
	  "code":""
   },
   "ADD":{
	  "def":"statement|counters|add %n(value) to %#(counter)",
	  "code":""
   },
   "SUBTRACT":{
	  "def":"statement|counters|subtract %n(value) from %#(counter)",
	  "code":""
   },
   "MULTIPLY":{
	  "def":"statement|counters|multiply %#(counter) by %n(value)",
	  "code":""
   },
   "DIVIDE":{
	  "def":"statement|counters|divide %#(counter) by %n(value)",
	  "code":""
   },
   "ASSIGN":{
	  "def":"statement|counters|set %#(counter) to %n(value)",
	  "code":""
   },
   "JOIN":{
	  "def":"string|strings|join %str(a) %str(b)",
	  "code":""
   },
   "LETTER":{
	  "def":"string|strings|letter %n(i) of %str(text)",
	  "code":""
   },
   "LENGTH":{
	  "def":"string|strings|length of %str(text)",
	  "code":""
   },
   "STRING_CONTAINS":{
	  "def":"boolean|strings|%str(text1) contains %str(text2)",
	  "code":""
   },
   "STRING_STARTS":{
	  "def":"boolean|strings|%str(text1) starts with %str(text2)",
	  "code":""
   },
   "STRING_ENDS":{
	  "def":"boolean|strings|%str(text1) ends with %str(text2)",
	  "code":""
   },
   "STRING_INDEX":{
	  "def":"number|strings|position of %str(text2) in %str(text2)",
	  "code":""
   },
   "STRING_IS_EMPTY":{
	  "def":"boolean|strings|is %str(text) empty",
	  "code":""
   },
   "STRING_IS_LOWERCASE":{
	  "def":"boolean|strings|is %str(text) lowercase",
	  "code":""
   },
   "STRING_IS_UPPERCASE":{
	  "def":"boolean|strings|is %str(text) uppercase",
	  "code":""
   },
   "STRING_INTERLACE":{
	  "def":"string|strings|interlace %str(text) in %arr(array)",
	  "code":""
   },
   "STRING_LOWERCASE":{
	  "def":"string|strings|make %str(text) lowercase",
	  "code":""
   },
   "STRING_UPPERCASE":{
	  "def":"string|strings|make %str(text) uppercase",
	  "code":""
   },
   "STRING_REVERSE":{
	  "def":"string|strings|reverse %str(text)",
	  "code":""
   },
   "STRING_SPLIT":{
	  "def":"array|strings|split %str(text) with %str(separator)",
	  "code":""
   },
   "SUBSTRING":{
	  "def":"string|strings|part of %str(text) from %n(a) to %n(b)",
	  "code":""
   },
   "CLEAR_ARRAY":{
	  "def":"statement|arrays|clear %arr(array)",
	  "code":""
   },
   "ARRAY_CONTAINS":{
	  "def":"boolean|arrays|%arr(array) contains %any(el)",
	  "code":""
   },
   "ARRAY_INDEX":{
	  "def":"number|arrays|position of %any(el) in %arr(array)",
	  "code":""
   },
   "ARRAY_EMPTY":{
	  "def":"boolean|arrays|is %arr(array) empty",
	  "code":""
   },
   "ARRAY_MAX":{
	  "def":"number|arrays|max number in %arr(array)",
	  "code":""
   },
   "ARRAY_MIN":{
	  "def":"number|arrays|min number in %arr(array)",
	  "code":""
   },
   "ARRAY_POP":{
	  "def":"statement|arrays|remove last element from %arr(array)",
	  "code":""
   },
   "ARRAY_SHIFT":{
	  "def":"statement|arrays|remove first element from %arr(array)",
	  "code":""
   },
   "ARRAY_REMOVE":{
	  "def":"statement|arrays|remove element at position %n(pos) from %arr(array)",
	  "code":""
   },
   "ARRAY_PUSH":{
	  "def":"statement|arrays|add %any(el) to %arr(array)",
	  "code":""
   },
   "ARRAY_REVERSE":{
	  "def":"statement|arrays|reverse %arr(array)",
	  "code":""
   },
   "ARRAY_SORT":{
	  "def":"array|arrays|sort %arr(array)",
	  "code":""
   },
   "ARRAY_SUM":{
	  "def":"number|arrays|sum of numbers in %arr(array)",
	  "code":""
   },
   "ARRAY_UNSHIFT":{
	  "def":"statement|arrays|add %any(el) to the start of %arr(array)",
	  "code":""
   },
   "RANGE":{
	  "def":"array|arrays|range from %n(start) to %n(end)",
	  "code":""
   },
   "RANGE_STEP":{
	  "def":"array|arrays|range from %n(start) to %n(end) with step %n(step)",
	  "code":""
   },
   "TYPE_RANGE":{
	  "def":"array|arrays|%list(type)[group,color,block,item] range from %n(start) to %n(end)",
	  "code":""
   },
   "TYPE_RANGE_STEP":{
	  "def":"array|arrays|%list(type)[group,color,block,item] range from %n(start) to %n(end) with step %n(step)",
	  "code":""
   },
   "OBJECT_ADD":{
	  "def":"statement|objects|add %obj(object) to level",
	  "code":""
   },
   "OBJECT_SET":{
	  "def":"statement|objects|set key %str(key) of %obj(object) to %any(value)",
	  "code":""
   },
   "PLUS":{
	  "def":"number|operators|%n(a) + %n(b)",
	  "code":""
   },
   "MINUS":{
	  "def":"number|operators|%n(a) - %n(b)",
	  "code":""
   },
   "MULT":{
	  "def":"number|operators|%n(a) * %n(b)",
	  "code":""
   },
   "DIV":{
	  "def":"number|operators|%n(a) / %n(b)",
	  "code":""
   },
   "MOD":{
	  "def":"number|operators|%n(a) `% %n(b)",
	  "code":""
   },
   "POW":{
	  "def":"number|operators|%n(a) ^ %n(b)",
	  "code":""
   },
   "ABS":{
	  "def":"number|operators|abs %n(x)",
	  "code":""
   },
   "TRIG":{
	  "def":"number|operators|%list(op)[sin,cos,tan,asin,acos,atan] %n(x)",
	  "code":""
   },
   "ROUND":{
	  "def":"number|operators|%list(op)[round,floor,ceil] %n(x)",
	  "code":""
   },
   "EULER":{
	  "def":"number|operators|%list(op)[e^,ln] %n(x)",
	  "code":""
   },
   "SQRT":{
	  "def":"number|operators|sqrt %n(x)",
	  "code":""
   },
   "NOT":{
	  "def":"boolean|operators|not %bool(a)",
	  "code":""
   },
   "AND":{
	  "def":"boolean|operators|%bool(a) and %bool(b)",
	  "code":""
   },
   "OR":{
	  "def":"boolean|operators|%bool(a) or %bool(b)",
	  "code":""
   },
   "XOR":{
	  "def":"boolean|operators|%bool(a) xor %bool(b)",
	  "code":""
   },
   "EQUALS":{
	  "def":"boolean|operators|%n(a) = %n(b)",
	  "code":""
   },
   "GREATER":{
	  "def":"boolean|operators|%n(a) > %n(b)",
	  "code":""
   },
   "LESSER":{
	  "def":"boolean|operators|%n(a) < %n(b)",
	  "code":""
   },
   "GREATER_EQ":{
	  "def":"boolean|operators|%n(a) ≥ %n(b)",
	  "code":""
   },
   "LESSER_EQ":{
	  "def":"boolean|operators|%n(a) ≤ %n(b)",
	  "code":""
   }
}
