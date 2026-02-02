class_name MovePlayerState extends PlayerState

func _ready() -> void:
	name = "move"

func enter():
	if p.hud: p.hud.change_current_state(name)
	p.canFocus = true
	if p.current_soul < 33:
		p.canFocus = false

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if not p.is_gameplay: return
	
	c.handle_input()
	c.handle_attacks()

func update_physics(delta: float):
	if not p.is_gameplay: return
	
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()
