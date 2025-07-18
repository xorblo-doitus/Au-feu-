class_name World
extends Node2D


var _started: bool = false


func start():
	if _started:
		return
	_started = true
	
	for start_lit in get_tree().get_nodes_in_group(&"start_lit"):
		if start_lit is BurnableArea:
			start_lit.lit = true
		elif "burnable_area" in start_lit:
			start_lit.burnable_area.lit = true



func _input(event: InputEvent) -> void:
	if event.is_action(&"start"):
		start()
