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
	$".".queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("spikes") and can_pogo:
		p.pogo_velocity = -Vector2.from_angle(global_rotation) * 350
		p.pogo_velocity.x *= 1.5
		p.pogo_velocity = p.pogo_velocity.round()
		p.camera.pogo_velocity_buffer = p.pogo_velocity
		can_pogo = false
