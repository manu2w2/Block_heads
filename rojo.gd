extends TextureRect

@export var drop_target: TextureRect
var original_position: Vector2

func _ready():
	original_position = position

func _get_drag_data(_at_position):
	var preview = TextureRect.new()
	preview.texture = texture
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	preview.size = Vector2(30,30)

	var container = Control.new()
	container.add_child(preview)
	set_drag_preview(container)

	return self


func _can_drop_data(_pos, _data):
	return true


func _drop_data(_pos, data):
	var mouse_pos = get_global_mouse_position()
	var hovered = drop_target.get_global_rect().has_point(mouse_pos)

	if hovered:
		# Copiar la textura del objeto arrastrado
		drop_target.texture = data.texture
		
		# Ocultar el objeto original
		data.visible = false
	else:
		# Si falló, regresar a su posición original
		data.position = data.original_position
