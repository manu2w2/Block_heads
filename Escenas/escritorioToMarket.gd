extends StaticBody2D

@onready var Navegador: Area2D = $Interactable

func _ready() -> void:
	Navegador.interact = _on_interact
	
func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/market.tscn")
