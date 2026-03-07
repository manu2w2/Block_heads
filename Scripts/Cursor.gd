extends CharacterBody2D

@export var speed: float = 120.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	
	var dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	if dir == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = dir.normalized() * speed

	move_and_slide()
	_animate()


func _animate() -> void:
	anim.play("Idle")
