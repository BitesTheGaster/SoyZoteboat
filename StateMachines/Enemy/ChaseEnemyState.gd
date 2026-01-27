class_name ChaseEnemyState extends EnemyState

func _ready() -> void:
	name = "chase"

func enter():
	if e.leg and e.leg2:
		e.leg.show()
		e.leg2.show()

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	c.handle_damage()
	c.handle_movement(e.CHASE_SPEED)
	c.handle_chase()
	c.handle_physics(delta)
