extends StaticBody2D

@onready var Buscar: Area2D = $Buscar
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	Buscar.interact = _on_interact
	anim.animation_finished.connect(_on_animation_finished)

func _on_interact():
	anim.play("Busqueda")  # nombre de tu animación

func _on_animation_finished():
	get_tree().change_scene_to_file("res://market.tscn")
