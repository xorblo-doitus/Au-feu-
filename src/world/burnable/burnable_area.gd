class_name BurnableArea
extends Area2D



@export var lit: bool = false: set = set_lit
@export var time_between_sparkling: float = 0.2
@export_range(0, 1) var litting_on_receiving_sparkle_chance: float = 0.5

@onready var timer: Timer = $Timer


func _ready() -> void:
	set_lit(lit)


func sparkle() -> void:
	for area: BurnableArea in get_overlapping_areas():
		area.catch_fire()


func catch_fire() -> void:
	if lit:
		return
	if randf() <= litting_on_receiving_sparkle_chance:
		lit = true


func set_lit(new: bool) -> void:
	lit = new
	
	if not is_node_ready():
		return
	
	if lit:
		timer.start()
		timer.wait_time = time_between_sparkling
	else:
		timer.stop()
	
	for child in get_children():
		if child is CanvasItem:
			child.visible = lit


func _on_timer_timeout() -> void:
	sparkle()
