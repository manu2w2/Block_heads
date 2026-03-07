extends StaticBody2D

@onready var Navegador: Area2D = $Navegador

func _ready() -> void:
	Navegador.interact = _on_interact
	
func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/google.tscn")
