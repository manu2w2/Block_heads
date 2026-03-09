extends CharacterBody2D

@export var speed: float = 120.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var footsteps: AudioStreamPlayer = $AudioStreamPlayer
var puede_sonar: bool = true
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
	_animate(dir)


func _animate(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		anim.play("Idle")
		footsteps.stop()
		return
	
	if puede_sonar:
		footsteps.play()
		puede_sonar = false
		# Espera 0.35 segundos antes del siguiente paso
		await get_tree().create_timer(1).timeout
		puede_sonar = true
	
	
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0.0:
			anim.play("Izquierda")
			anim.flip_h = true
			
		else:
			anim.play("Izquierda")
			anim.flip_h = false
			
			
	else:
		if dir.y > 0.0:
			anim.play("Abajo")
			
		else:
			anim.play("Arriba")
			
