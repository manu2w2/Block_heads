extends Node2D
@onready var animacion_cadenarota: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D 
@onready var animacion_cadenarota2: AnimatedSprite2D = $StaticBody2D2/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion_cadenarota. play("default")
	animacion_cadenarota2. play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
