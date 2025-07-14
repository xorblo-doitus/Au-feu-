@tool
extends Node2D


func _ready() -> void:
	print(owner)
	if Engine.is_editor_hint() and owner != null:
		var rand:= RandomNumberGenerator.new()
		rand.seed = name.hash()
		modulate = Color(
			1.0 - rand.randf() /10,
			1.0 - rand.randf() /10,
			1.0 - rand.randf() /10,
		)
