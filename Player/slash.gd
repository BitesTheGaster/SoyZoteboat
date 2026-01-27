class_name Slash extends Area2D

@onready var p : Player = get_parent().get_parent().get_parent()
var can_pogo := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p.attacking = true
	p.canAttack = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dead_timer_timeout() -> void:
	p.attacking = false
	p.attack_delay.start()
	$CollisionShape2D.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		$CPUParticles2D.global_position = (area.global_position+global_position)/2
		$CPUParticles2D.emitting = true
	if ( area.is_in_group("spikes") or area.is_in_group("enemy") ) and can_pogo:
		p.pogo_velocity = -Vector2.from_angle(global_rotation) * 350
		p.pogo_velocity.x *= 1.5
		p.pogo_velocity = p.pogo_velocity.round()
		p.camera.pogo_velocity_buffer = p.pogo_velocity
		can_pogo = false
		if area.is_in_group("enemy"):
			area.get_parent().knockback = Vector2.from_angle(global_rotation) * 350
			area.get_parent().knockback.x *= 3
			area.get_parent().knockback.y -= 100.0
			if not area.get_parent().is_invincible:
				area.get_parent().health -= p.Damage
			area.get_parent().inv_frames.start()
			area.get_parent().is_invincible = true


func _on_cpu_particles_2d_finished() -> void:
	$".".queue_free()
