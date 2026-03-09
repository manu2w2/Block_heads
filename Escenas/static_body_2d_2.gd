extends StaticBody2D
@onready var timerr: Timer = $"../../Timer"
@onready var nuevo_sprite = $"StaticBody2D4/Sprite2D2"
@onready var sprite_resultado = $"StaticBody2D4/Good"
@onready var sprite_objeto = $"StaticBody2D4/Sprite2D"
func _input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			sprite_resultado.visible = true
			nuevo_sprite.visible = !nuevo_sprite.visible
			
			sprite_resultado.visible = false
	get_tree().change_scene_to_file("res://Escenas/escritorio.tscn")
