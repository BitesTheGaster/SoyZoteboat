class_name IdleEnemyState extends EnemyState

func _ready() -> void:
	name = "idle"

func enter():
	pass

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	c.handle_damage()
	c.handle_movement()
	c.handle_physics(delta)
