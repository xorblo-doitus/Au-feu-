extends Node2D


@export var first_level: PackedScene


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)
