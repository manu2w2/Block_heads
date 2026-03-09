extends TextureRect

@export var drop_target: TextureRect  # arrastra B1 aquí en el inspector
var original_position: Vector2

func _ready():
	original_position = position

func _get_drag_data(at_position):
	var preview = TextureRect.new()
	preview.texture = texture
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	preview.size = Vector2(30,30)

	var container = Control.new()
	container.add_child(preview)
	set_drag_preview(container)
	return self

func _can_drop_data(_pos, data):
	# Solo permitimos dropear en el nodo asignado
	return true

func _drop_data(_pos, data):
	# Obtenemos nodo bajo el mouse
	var mouse_pos = get_global_mouse_position()
	var hovered = drop_target.get_global_rect().has_point(mouse_pos)
	
	if hovered:
		# Drop correcto: replicamos la textura
		drop_target.texture = texture
		
		
	# Siempre volver a posición original
	position = original_position
	
	
	
