class_name PlayerController extends Node

@export var p: Player

func _process(delta: float) -> void:
	if not p.is_gameplay: return
	
	p.falling = p.velocity.y > 0
	if p.jumping and p.falling:
		p.jumping = false
	elif Input.is_action_just_pressed("Jump") and p.velocity.y <= 0:
		p.jumping = true
	

func _physics_process(delta: float) -> void:
	if not p.is_gameplay: return
	
	p.move_and_slide()

func handle_physics(delta: float):
	# Add the gravity.
	if not p.is_on_floor():
		p.velocity += p.G * delta
	
	#Add pogo knockback
	if p.pogo_velocity.x:
		p.velocity.x = p.pogo_velocity.x
		p.current_speed = 0
		p.pogo_velocity.x = 0
	if p.pogo_velocity.y:
		p.velocity.y = p.pogo_velocity.y
		p.pogo_velocity.y = 0
	
	if p.active_input:
		# Controlable jump height
		if p.jumping and Input.is_action_just_released("Jump"):
			p.velocity.y = 0
			p.move_and_slide()

func handle_input():
	if p.active_input:
		p.raw_dir = Input.get_vector("Left", "Right", "Up", "Down")
		if not p.dashing:
			p.move_dir = p.raw_dir.x
		if p.raw_dir and !p.attacking:
			var ang = Vector2.ZERO
			if p.raw_dir.y:
				ang = Vector2(0, p.raw_dir.y)
			else:
				ang = Vector2(p.raw_dir.x, 0)
			p.slash_center.rotation = ang.angle()
		if Input.is_action_just_pressed("Dash") and p.canDash:
			p.dashing = true
			p.dash_length.start()

func handle_movement():
	p.current_speed = lerp(p.current_speed, p.SPEED, 0.2)
	if p.move_dir:
		p.velocity.x = move_toward(p.velocity.x, p.move_dir * p.SPEED, p.current_speed)
	else:
		p.velocity.x = move_toward(p.velocity.x, 0, p.current_speed)

func handle_jump():
	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		p.velocity.y = p.JUMP_VELOCITY

func handle_attacks():
	if p.active_input:
		if Input.is_action_just_pressed("Slash") and p.canAttack:
			var slash_scene = p.slash_scene.instantiate()
			p.slash_pos.add_child(slash_scene)

func handle_collisions():
	if p.collision

func _on_attack_delay_timeout() -> void:
	p.canAttack = true

func _on_dash_length_timeout() -> void:
	p.dashing = false

func _on_inv_frames_timeout() -> void:
	p.is_invincible = false
