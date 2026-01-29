class_name Hud extends Control

func _ready() -> void:
	for child in $VBoxContainer/HBoxContainer/Health.get_children():
		child.modulate = Color.GHOST_WHITE

func change_current_state(state_name: String):
	$VBoxContainer/Current_state.text = "Current state: " + state_name

func update_health(new_hp: int):
	var cnt := 1
	for child in $VBoxContainer/HBoxContainer/Health.get_children():
		if cnt<=new_hp:
			child.modulate = Color.GHOST_WHITE
		else:
			child.modulate = Color.INDIAN_RED
		cnt += 1

func update_soul(new_soul: int):
	$VBoxContainer/HBoxContainer/CurrentSoul.value = new_soul
