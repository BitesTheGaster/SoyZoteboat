class_name PlayerController extends Node

@export var p: Player

func _process(delta: float) -> void:
	if not p.is_gameplay: return
	
	# Quit game if player dies
	if p.Health <= 0:
		get_tree().quit()
	
	# Make player purple while invinsible
	if p.is_invincible:
		p.sprite.modulate = Color.PURPLE
	else:
		p.sprite.modulate = Color.GREEN
	
	# Updating slash position
	if !p.attacking:
		var ang = Vector2.ZERO
		if p.raw_dir.y:
			ang = Vector2(0, p.raw_dir.y)
		else:
			ang = Vector2(p.last_dir, 0)
		p.slash_center.rotation = ang.angle()
	
	# Face player to last pressed direction
	p.sprite.flip_v = p.last_dir == -1
	
	# Updating base variables
	p.falling = p.velocity.y > 0
	if p.jumping and p.falling:
		p.jumping = false
	elif Input.is_action_just_pressed("Jump") and p.velocity.y <= 0:
		p.jumping = true
	if p.is_on_floor() and not p.canDash:
		p.canDash = true
	

func _physics_process(delta: float) -> void:
	if not p.is_gameplay: return
	
	# Apply player moves
	p.move_and_slide()

func handle_physics(delta: float):
	# Add the gravity
	if not p.is_on_floor() or not p.dashing:
		p.velocity += p.G * delta
	
	# Add pogo knockback
	if p.pogo_velocity.x:
		p.velocity.x = p.pogo_velocity.x
		p.current_speed = 0
		p.pogo_velocity.x = 0
	if p.pogo_velocity.y:
		p.velocity.y = p.pogo_velocity.y
		p.canDash = p.canDash or p.pogo_velocity.y < 0
		if p.canDash: p.dash_delay.stop()
		p.pogo_velocity.y = 0
	
	if p.active_input:
		# Controlable jump height
		if p.jumping and Input.is_action_just_released("Jump"):
			p.velocity.y = 0
			p.move_and_slide()

func handle_input():
	if p.active_input:
		# Get move input
		p.raw_dir = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
		p.move_dir = p.raw_dir.x
		if p.raw_dir.x and !p.dashing:
			p.last_dir = p.raw_dir.x
		
		# Get dash input
		p.canDash = p.canDash and p.dash_delay.is_stopped()
		if Input.is_action_just_pressed("Dash") and p.canDash:
			p.dash_particles.emitting = true
			p.dashing = true
			p.canDash = false
			p.dash_length.start()

func handle_movement():
	# Move player left and right
	p.current_speed = lerp(p.current_speed, p.SPEED, 0.2)
	if not p.dashing:
		if p.move_dir:
			p.velocity.x = move_toward(p.velocity.x, p.move_dir * p.SPEED, p.current_speed)
		else:
			p.velocity.x = move_toward(p.velocity.x, 0, p.current_speed)
	# Move player while dash
	else:
		p.velocity.x = p.last_dir * p.SPEED * 6
		p.velocity.y = 0.0
func handle_jump():
	# Handle jump
	if Input.is_action_just_pressed("Jump"):
		p.velocity.y = p.JUMP_VELOCITY

func handle_attacks():
	if p.active_input:
		# Create slash
		if Input.is_action_just_pressed("Slash") and p.canAttack:
			var slash_scene = p.slash_scene.instantiate()
			p.slash_pos.add_child(slash_scene)

func _on_attack_delay_timeout() -> void:
	p.canAttack = true

func _on_dash_length_timeout() -> void:
	p.dashing = false
	p.dash_delay.start()

func _on_inv_frames_timeout() -> void:
	p.is_invincible = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	# Taking damage from spikes
	if area.is_in_group("spikes"):
		p.damage_particles.emitting = true
		p.is_invincible = true
		p.inv_frames.start()
		p.Health -= 1
		p.hud.update_health(p.Health)
		#reset player position
		p.position = Vector2.ZERO
		p.velocity = Vector2.ZERO
		p.canAttack = true
		p.canDash = true
		p.dashing = false
		p.attacking = false
