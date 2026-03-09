

# Called when the node enters the scene tree for the first time.
extends Node2D

func _ready() -> void:
	
	Music.musica.stream = load("res://Assets/music/the_mountain-deep-house-483808.mp3")
	
	Music.musica.play()
	
	print("esperando...")
	
	await get_tree().create_timer(4.0).timeout
	
	print("cambiando escena")
	
	get_tree().change_scene_to_file("res://Escenas/Minijuego Blockchain.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
