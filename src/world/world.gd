class_name World
extends Node2D


var _started: bool = false



func _ready() -> void:
	SignalBus.lit_count_changed.connect(_on_lit_count_changed)


func _on_lit_count_changed(new: int) -> void:
	if new == 0:
		print("end")


func start():
	if _started:
		return
	_started = true
	
	for start_lit in get_tree().get_nodes_in_group(&"start_lit"):
		if start_lit is BurnableArea:
			start_lit.lit = true
		elif "burnable_area" in start_lit:
			start_lit.burnable_area.lit = true


func reset() -> void:
	if not _started:
		return
	
	for burnable: BurnableArea in get_tree().get_nodes_in_group("burnable"):
		burnable.reset()
	_started = false



func _input(event: InputEvent) -> void:
	if event.is_action(&"start"):
		start()
