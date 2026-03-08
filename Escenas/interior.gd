extends Node2D

@onready var camara_jugador = $Jugador/Camera2D
@onready var camara_escena = $Camera2D


func _ready():
	activar_camara_escena()


func activar_camara_escena():
	camara_escena.make_current()
