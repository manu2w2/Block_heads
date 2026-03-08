# Script para BodyB1 o un Node2D que controle las colisiones
extends Node2D

@onready var colision_b1 = $"BodyB1/ColisionB1"
@onready var body_rojo = $"BodyRojo"

func _process(delta):
	# Recorremos todos los StaticBody2D de la escena
	for body in get_tree().get_nodes_in_group("static_bodies"):
		if body == body_rojo:
			continue  # Ignoramos el rojo
		if body == colision_b1.get_parent():
			continue  # Ignoramos nuestro propio body

		# Comprobamos si las CollisionShape2D colisionan
		var shape_b1 = colision_b1.shape
		var shape_other = body.get_node("ColisionShape2D").shape
		if shape_b1.collide(colision_b1.global_transform, shape_other, body.get_node("ColisionShape2D").global_transform):
			get_tree().reload_current_scene()
