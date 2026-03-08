extends CharacterBody2D

@export var speed: float = 120.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	_animate()

func _animate() -> void:
	anim.play("Idle")
