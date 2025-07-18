class_name BurnableArea
extends Area2D



@export var lit: bool = false: set = set_lit
@export var time_between_sparkling: float = 0.2
@export_range(0, 1) var litting_on_receiving_sparkle_chance: float = 0.5
@export_range(0.001, 10) var life_time: float = 3

#@export_range() var max_health: int = 10

@onready var sparkle_timer: Timer = $SparkleTimer
@onready var life_timer: Timer = $LifeTimer
var _life_timer_started: bool = false
var _life_tween: Tween


#func _ready() -> void:
	#set_lit(not lit)
	#set_lit(not lit)


func sparkle() -> void:
	var overlapping_areas := get_overlapping_areas()
	for area in overlapping_areas:
		if area is ExtinguisherArea:
			lit = false
			return
	
	for area: BurnableArea in overlapping_areas:
		area.catch_fire()


func catch_fire() -> void:
	if lit:
		return
	if randf() <= litting_on_receiving_sparkle_chance:
		lit = true


func set_lit(new: bool) -> void:
	if _life_timer_started and _life_tween == null:
		new = false
	
	if new == lit:
		return
	
	lit = new
	
	if not is_node_ready():
		return
	
	if lit:
		sparkle_timer.start()
		sparkle_timer.wait_time = time_between_sparkling
		if _life_timer_started == false:
			_life_timer_started = true
			life_timer.start(life_time)
			_life_tween = create_tween()
			_life_tween.tween_property(
				get_parent(),
				^"burn_progress",
				1.0,
				life_timer.time_left
			).from(0.0)
		else:
			life_timer.paused = false
		_life_tween.play()
	else:
		sparkle_timer.stop()
		if not (_life_timer_started and _life_tween == null):
			if _life_timer_started:
				life_timer.paused = true
				_life_tween.pause()
	
	for child in get_children():
		if child is CanvasItem:
			child.visible = lit


func _on_timer_timeout() -> void:
	sparkle()


func _on_life_timer_timeout() -> void:
	_life_tween = null
	lit = false
