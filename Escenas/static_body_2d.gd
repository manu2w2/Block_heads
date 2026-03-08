extends StaticBody2D
@onready var sprite_resultado = get_node("StaticBody2D3/bAD")

func _input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			sprite_resultado.visible = true
			await get_tree().create_timer(2.0).timeout
			sprite_resultado.visible = false
