class_name FocusPlayerState extends PlayerState

func _ready() -> void:
	name = "focus"

func enter():
	if p.hud: p.hud.change_current_state(name)
	p.soul_drain.start()
	p.velocity.x = 0
	p.burned_soul = 0

func exit():
	p.soul_drain.stop()

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if not p.is_gameplay: return
	
	if p.current_soul == 0:
		p.hud.update_soul(p.current_soul)
		state_machine.change_state("idle")
	
	c.handle_input()

func update_physics(delta: float):
	if not p.is_gameplay: return
	
	c.handle_physics(delta)
