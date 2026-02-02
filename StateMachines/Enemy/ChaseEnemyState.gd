class_name ChaseEnemyState extends EnemyState

func _ready() -> void:
	name = "chase"

func enter():
	if e.dash_delay: e.dash_delay.start()
	if e.rage_sprite:
		e.rage_sprite.show()

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	c.handle_damage()
	if e.is_dashing:
		c.handle_movement(e.DASH_SPEED)
	else:
		c.handle_movement(e.CHASE_SPEED)
	c.handle_chase()
	c.handle_physics(delta)
