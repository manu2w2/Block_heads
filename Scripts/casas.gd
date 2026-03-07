extends StaticBody2D

@onready var EntrarCasa: Area2D = $EntrarCasa

func _ready() -> void:
	EntrarCasa.interact = _on_interact
	
func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
