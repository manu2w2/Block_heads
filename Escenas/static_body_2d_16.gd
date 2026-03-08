extends StaticBody2D
@onready var Interactable: Area2D = $Interactable
func _ready() -> void:
	Interactable.interact = _on_interact

func _on_interact():
	get_tree().change_scene_to_file("res://Escenas/escritorio.tscn")
