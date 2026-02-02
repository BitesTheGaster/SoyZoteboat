class_name RoomTransition extends Area2D

@export var exit_direction : Vector2
@export var p : Player

func get_exit_vector():
	if not exit_direction: return
	
	var exit_dir := exit_direction*150
	if exit_direction.y == 1:
		exit_dir.x += p.last_dir * 50
	
	return exit_dir
