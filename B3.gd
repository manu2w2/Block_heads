extends TextureRect

func _can_drop_data(_pos, data):
	# Solo aceptamos que se dropee el nodo llamado "Rojo"
	return data is TextureRect and data.name == "Naranja"

func _drop_data(_pos, data):
	# Validamos que sea Rojo
	if data is TextureRect and data.name == "Naranja":
		# Copiamos la textura de Rojo
		texture = data.texture
		get_tree().change_scene_to_file("res://block chain bien.tscn")
