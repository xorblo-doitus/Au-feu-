@tool
extends Node2D


func _ready() -> void:
	if Engine.is_editor_hint() and get_parent().owner != null:
		randomize_color()


func randomize_color() -> void:
	var rand:= RandomNumberGenerator.new()
	rand.seed = name.hash()
	modulate = Color(
		1.0 - rand.randf() / 8,
		1.0 - rand.randf() / 8,
		1.0 - rand.randf() / 8,
	)
