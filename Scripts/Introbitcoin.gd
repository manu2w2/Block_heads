extends StaticBody2D

@onready var timerr: Timer =  $"../Timer"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var Bitcoin: Sprite2D = $BitcoinMoneda
@onready var Karla: AnimatedSprite2D = $"Karla Nick"
@onready var Ulises: Sprite2D = $Ulibongles
@onready var panel: Panel = $Panel
@onready var menos: Sprite2D = $"0_0003Btc(1)"
@onready var mas: Sprite2D = $"0_0003Btc"

func _ready() -> void:
	# Ocultar sprites al inicio
	Ulises.visible = false
	Karla.visible = false
	panel.visible = false
	menos.visible = false
	mas.visible = false
	Bitcoin.visible = false
	

	# Reproducir la animación de AnimatedSprite2D
	anim.play("texto btc")
	
	
	
	# Iniciar el Timer
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	# Mostrar los sprites después del Timer
	Karla.visible = true
	panel.visible = true
	 
	# Iniciar el Timer
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	Bitcoin.visible = true
	
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	Ulises.visible = true
	
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	mas.visible = true
	
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	menos.visible = true
	
	timerr.start()
	
	# Esperar a que el Timer haga timeout
	await timerr.timeout
	
	
	
	
