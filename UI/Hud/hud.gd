class_name Hud extends Control

func _ready() -> void:
	for child in $VBoxContainer/HBoxContainer.get_children():
		child.modulate = Color.DARK_GOLDENROD

func change_current_state(state_name: String):
	$VBoxContainer/Current_state.text = "Current state: " + state_name

func update_health(new_hp: int):
	var cnt := 1
	for child in $VBoxContainer/HBoxContainer.get_children():
		if cnt<=new_hp:
			child.modulate = Color.DARK_GOLDENROD
		else:
			child.modulate = Color.LIGHT_GOLDENROD
		cnt += 1
