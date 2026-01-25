extends Camera2D

@onready var p : Player = $"../Player"

var target_position := Vector2.ZERO
var pogo_velocity_buffer := Vector2.ZERO
func _process(delta: float) -> void:
	if pogo_velocity_buffer and $PogoShakeBuffer.is_stopped():
		$PogoShakeBuffer.start()
	
	target_position = p.position
	target_position += p.velocity/50
	target_position.x += randf_range(-pogo_velocity_buffer.length(), pogo_velocity_buffer.length())/15
	target_position.y += randf_range(-pogo_velocity_buffer.length(), pogo_velocity_buffer.length())/15
	position = lerp(position, target_position, 0.3)


func _on_pogo_shake_buffer_timeout() -> void:
	pogo_velocity_buffer = p.pogo_velocity
