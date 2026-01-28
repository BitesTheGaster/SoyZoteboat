class_name EnemyStateMachine extends StateMachine

@onready var rage_time : Timer = $"../RageTime"

@export var e: Enemy

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)

func _on_rage_time_timeout() -> void:
	change_state("idle")

func _on_chase_range_body_entered(body) -> void:
	if body.is_in_group("player"):
		rage_time.stop()
		e.target = body
		change_state("chase")

func _on_chase_range_body_exited(body) -> void:
	if body.is_in_group("player") and rage_time.is_stopped():
		if rage_time.is_inside_tree(): rage_time.start()


func _on_dash_time_timeout() -> void:
	if current_state.name == "chase":
		e.is_dashing = false
		e.dash_delay.start()


func _on_dash_delay_timeout() -> void:
	if current_state.name == "chase":
		e.is_dashing = true
		e.dash_time.start()
