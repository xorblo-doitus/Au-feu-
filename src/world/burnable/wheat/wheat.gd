@tool
extends Node2D


@onready var wheat: Sprite2D = $Wheat
@onready var burnable_area: BurnableArea = $BurnableArea


@export var base_color: Color:
	set(new):
		base_color = new
		_update_color()
@export var burn_progress: float = 0:
	set(new):
		burn_progress = new
		_update_color()


var _burned_color: Color


func _ready() -> void:
	randomize_color()


func randomize_color() -> void:
	var rand:= RandomNumberGenerator.new()
	rand.seed = name.hash()
	var _burned: float = rand.randf() / 5
	_burned_color = Color(_burned, _burned, _burned)
	base_color = Color(
		1.0 - rand.randf() / 8,
		1.0 - rand.randf() / 8,
		1.0 - rand.randf() / 8,
	)


func _update_color() -> void:
	if is_node_ready():
		wheat.modulate = base_color.lerp(_burned_color, burn_progress)
