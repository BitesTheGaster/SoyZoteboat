class_name EnemyController extends Node

@export var e: Enemy

func _process(delta: float) -> void:
	if e.health <= 0:
		e.queue_free()

func _physics_process(delta: float) -> void:
	pass

func handle_physics(delta: float):
	# Add the gravity
	if not e.is_on_floor():
		e.velocity += e.G * delta
	
	e.move_and_slide()

func handle_movement(CURRENT_SPEED):
	if e.move_dir:
		e.velocity.x = move_toward(e.velocity.x, e.move_dir * CURRENT_SPEED, CURRENT_SPEED)
	else:
		e.velocity.x = move_toward(e.velocity.x, 0.0, CURRENT_SPEED)

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
		

func handle_chase():
	if not e.target: return
	if e.position.x < e.target.position.x:
		if e.can_go_right: e.move_dir = 1
		else: e.move_dir = 0
	else:
		if e.can_go_left: e.move_dir = -1
		else: e.move_dir = 0

func _on_inv_frames_timeout() -> void:
	e.is_invincible = false

func _on_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("block"): e.can_go_right = true


func _on_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("block"): e.can_go_right = false


func _on_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("block"): e.can_go_left = true


func _on_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("block"): e.can_go_left = false
