extends Node2D
@onready var tiempo: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Iniciar el Timer
	tiempo.start()
	
	# Esperar a que el Timer haga timeout
	await tiempo.timeout
	get_tree().change_scene_to_file("res://Minijuego Blockchain.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
