extends PanelContainer


func set_type(var type):
	$DetailContainer/Type.text = type

func set_description(var desc):
	$DetailContainer/Description.text = desc
	$DetailContainer/Description.modulate.a = 1


