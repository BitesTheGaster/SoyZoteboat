class_name AirbornePlayerState extends PlayerState

func _ready() -> void:
	name = "airborne"

func enter():
	if p.hud: p.hud.change_current_state(name)

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
