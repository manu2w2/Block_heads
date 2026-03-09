extends StaticBody2D
@onready var Entraresc: Area2D = $Area2D
func _ready() -> void:
	Entraresc.interact = _on_interact

func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/escritorio.tscn")
