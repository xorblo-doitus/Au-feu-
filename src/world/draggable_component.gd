class_name DraggableComponent
extends Area2D

static var hovered: DraggableComponent

var _dragging: bool = false
var _offset_to_mouse: Vector2 = Vector2.ZERO
var _dragged_global_position: Vector2:
	set(new):
		get_parent().global_position = new
	get: return get_parent().global_position


func _unhandled_input(event: InputEvent) -> void:
	if hovered == self:
		if event is InputEventMouseButton:
			_unhandled_mouse_button_input(event)
		elif _dragging and event is InputEventMouseMotion:
			_dragged_global_position = event.global_position + _offset_to_mouse


func _unhandled_mouse_button_input(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if not _dragging:
				_dragging = true
				_offset_to_mouse = _dragged_global_position - event.global_position
				Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		else:
			if _dragging:
				_dragging = false
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


# TODO fix hovering when leaving and entering another draggable at the same time
func _on_mouse_entered() -> void:
	if hovered == null:
		hovered = self
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	if hovered == self:
		hovered = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
