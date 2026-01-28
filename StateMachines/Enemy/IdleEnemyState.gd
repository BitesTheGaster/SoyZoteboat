class_name IdleEnemyState extends EnemyState

func _ready() -> void:
	name = "idle"

func enter():
	if e.dash_delay: e.dash_delay.stop()
	if e.dash_time: e.dash_time.stop()
	e.is_dashing = false
	e.move_dir = 0
	if e.leg and e.leg2:
		e.leg.hide()
		e.leg2.hide()

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if (e.move_dir < 0 and !e.can_go_left) or (e.move_dir > 0 and !e.can_go_right):
		e.move_dir = 0
	if randf() < 0.005:
		e.move_dir = randi_range(-1, 1)

func update_physics(delta: float):
	c.handle_damage()
	c.handle_movement(e.IDLE_SPEED)
	c.handle_physics(delta)
