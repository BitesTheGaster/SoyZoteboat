class_name EnemyController extends Node

@export var e: Enemy

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func handle_physics(delta: float):
	# Add the gravity
	if not e.is_on_floor():
		e.velocity += e.G * delta
	
	e.move_and_slide()

func handle_movement():
	if e.move_dir:
		e.velocity.x = move_toward(e.velocity.x, e.move_dir * e.IDLE_SPEED, e.IDLE_SPEED)
	else:
		e.velocity.x = move_toward(e.velocity.x, 0.0, e.IDLE_SPEED)

func handle_damage():
	if e.knockback:
		e.velocity = e.knockback*e.KNOCKBACK_MULTIPLIER
		e.knockback = Vector2.ZERO
	
	if e.taken_damage:
		if e.is_invincible:
			e.taken_damage = 0
		else:
			e.health -= e.taken_damage
			e.taken_damage = 0
			e.is_invincible = true
		


func _on_inv_frames_timeout() -> void:
	e.is_invincible = false
