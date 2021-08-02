extends ViewportContainer


func _input(ev):
	if ev is InputEventMouseButton:
		$Viewport.gui_disable_input = false
		if ev.position.x<rect_position.x or ev.position.y<rect_position.y or ev.position.x>(rect_position.x+rect_size.x) or ev.position.y>(rect_position.y+rect_size.y):
			$Viewport.gui_disable_input = true
