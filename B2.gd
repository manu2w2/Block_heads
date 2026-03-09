extends TextureRect

func _can_drop_data(_pos, data):
	# Solo aceptamos que se dropee el nodo llamado "Rojo"
	return data is TextureRect and data.name == "Verde"

func _drop_data(_pos, data):
	# Validamos que sea Rojo
	if data is TextureRect and data.name == "Verde":
		# Copiamos la textura de Rojo
		texture = data.texture
