extends Node2D

onready var CategoryTab = preload("res://editor/interface/block_panel/CategoryTab.tscn")
onready var BlockButton = preload("res://editor/interface/block_panel/BlockButton.tscn")


var moving_camera = false
var prev_mouse_pos = Vector2(0,0)
var prev_camera_pos = Vector2(0,0)

onready var Cam = $EditorLayer/VBoxContainer/HSplitContainer/ViewportContainer/Viewport/Camera
onready var BlockCanvas = $EditorLayer/VBoxContainer/HSplitContainer/ViewportContainer/Viewport/BlockCanvas
onready var BlockTabs = $EditorLayer/VBoxContainer/HSplitContainer/VSplitContainer/TabContainer
onready var Code = $EditorLayer/VBoxContainer/HSplitContainer/VSplitContainer/Code

func generate():
	
	var generated_code = ""
	generated_code += ConversionHandler.INIT_STRING
	
	for header in get_tree().get_nodes_in_group("header_block"):
		generated_code += "\n" + ConversionHandler.convert_block(header)
	
	Code.text = generated_code

func copy_code():
	
	OS.set_clipboard(Code.text)
	

func _ready():
	
	for i in EditorHandler.Categories.size():
		var new_tab = CategoryTab.instance()
		new_tab.name = EditorHandler.CATEGORY_NAMES[i]
		BlockTabs.add_child(new_tab)
		
	for i in BlockHandler.BLOCK_DEFINITIONS:
		var def = BlockHandler.BLOCK_DEFINITIONS[i]
		var new_button = BlockButton.instance()
		new_button.text = i
		new_button.canvas = BlockCanvas
		new_button.camera = Cam
		BlockTabs.get_node(EditorHandler.CATEGORY_NAMES[def.category]).get_node("ScrollContainer/ButtonContainer").add_child(new_button)
	
	$EditorLayer/VBoxContainer/HBoxContainer/Generate.connect("pressed",self,"generate")
	$EditorLayer/VBoxContainer/HBoxContainer/Copy.connect("pressed",self,"copy_code")
	
	
	

func _process(_delta):
	
	if Input.is_action_just_pressed("mouse_middle"):
		moving_camera = true
		prev_mouse_pos = get_viewport().get_mouse_position()
		prev_camera_pos = Cam.position
	if Input.is_action_just_released("mouse_middle"):
		moving_camera = false
		
	if moving_camera:
		Cam.position = prev_camera_pos - (get_viewport().get_mouse_position() - prev_mouse_pos)*Cam.zoom
	
	if Input.is_action_just_pressed("screenshot"):
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("user://screenshot.png")
	

