extends Node2D
@onready var timer: Timer = $Timer
@onready var tiempo: Timer = $Timer2
@onready var Flecha1: Sprite2D = $"Flecha 1"
@onready var Bloque: Sprite2D = $Bloque
@onready var Huella: Sprite2D = $Huella
@onready var Flecha2: Sprite2D = $"Flecha 2"
@onready var Cadena: Sprite2D = $Cadena
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Flecha1.visible = false
	Bloque.visible = false
	Huella.visible = false
	Flecha2.visible = false
	Cadena.visible = false
	
	# Iniciar el Timer
	timer.start()
	# Esperar a que el Timer haga timeout
	await timer.timeout
	Flecha1.visible = true
	Bloque.visible = true
	
	# Iniciar el Timer
	tiempo.start()
	# Esperar a que el Timer haga timeout
	await tiempo.timeout
	
	Flecha1.visible = false
	Bloque.visible = false
	
	# Iniciar el Timer
	timer.start()
	# Esperar a que el Timer haga timeout
	await timer.timeout
	Huella.visible = true
	
	# Iniciar el Timer
	tiempo.start()
	# Esperar a que el Timer haga timeout
	await tiempo.timeout
	Huella.visible = false
	
	# Iniciar el Timer
	timer.start()
	# Esperar a que el Timer haga timeout
	await timer.timeout
	Flecha2.visible = true
	Cadena.visible = true
	# Iniciar el Timer
	timer.start()
	# Esperar a que el Timer haga timeout
	await timer.timeout
	get_tree().change_scene_to_file("res://Escenas/Estafas.tscn")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
