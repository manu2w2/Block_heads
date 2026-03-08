# Script para un Node2D que controle la colisión de B1
extends Node2D

@onready var body_b1 = $B1
@onready var colision_b1 = $B1/ColisionB1
@onready var body_rojo = $Rojo

func _process(delta):
	var space_state = get_world_2d().direct_space_state

	# Configuramos la consulta de colisión
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = colision_b1.shape
	query.transform = body_b1.global_transform
	query.collide_with_bodies = true
	query.exclude = [body_b1]  # Excluimos B1

	var results = space_state.intersect_shape(query)
	for result in results:
		var collider = result.collider
		if collider != body_rojo:
			get_tree().reload_current_scene()
			break
