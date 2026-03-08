extends Sprite2D

var move = false
var enter = false

func _physics_process(delta):
	var mousepos = get_global_mouse_position()

	if Input.is_action_pressed("Click") and enter == true:
		move = true
	else:
		move = false

	if move:
		position = mousepos


func _on_area_2d_mouse_entered():
	enter = true


func _on_area_2d_mouse_exited():
	if move == false:
		enter = false
