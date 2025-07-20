class_name World
extends Node2D


@export var next_level: PackedScene
@onready var life: ProgressBar = $UI/Buttons/WinLife/Life
@export var win_life: float = 80

var _started: bool = false

@onready var win_life_progress: ProgressBar = $UI/Buttons/WinLife


func _ready() -> void:
	SignalBus.lit_count_changed.connect(_on_lit_count_changed)
	calculate_life()
	win_life_progress.value = win_life


func _on_lit_count_changed(new: int) -> void:
	if _started and new == 0:
		if win_life_progress.value <= life.value:
			$WinSound.play()
			await $WinSound.finished
			get_tree().change_scene_to_packed(next_level)
		else:
			$LooseSound.play()
	calculate_life()


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
	_started = false
	
	for burnable: BurnableArea in get_tree().get_nodes_in_group("burnable"):
		burnable.reset()
	calculate_life()


func calculate_life() -> void:
	if not is_inside_tree():
		return
	var burnable_areas := get_tree().get_nodes_in_group("burnable")
	var progress_sum: float = 0
	for burnable: BurnableArea in burnable_areas:
		progress_sum += burnable.burn_progress
	life.value = (1 - progress_sum / len(burnable_areas)) * 100


func _input(event: InputEvent) -> void:
	if event.is_action(&"start"):
		start()
