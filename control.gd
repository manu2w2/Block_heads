extends Control

@onready var music: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	music.play()

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Hub.tscn")

func _on_opciones_pressed() -> void:
	print("Opciones - próximamente")

func _on_salir_pressed() -> void:
	get_tree().quit()