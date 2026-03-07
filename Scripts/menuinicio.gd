extends Control

@onready var music: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	music.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/calle.tscn")

func _on_opciones_pressed() -> void:
	print("Opciones - próximamente")

func _on_exit_pressed() -> void:
	get_tree().quit()
