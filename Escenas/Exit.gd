extends StaticBody2D

@onready var exit: Area2D = $Exit/Interactable

func _ready() -> void:
	exit.interact = _on_interact
	
func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/interior.tscn")
