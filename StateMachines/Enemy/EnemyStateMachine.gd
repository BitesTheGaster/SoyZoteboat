class_name EnemyStateMachine extends StateMachine

@export var e: Enemy

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)
