extends Camera2D

@onready var morado: AnimatedSprite2D = $"../StaticBody2D/AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	morado.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
