class_name ErrorPopup
extends AcceptDialog


## A singleton displaying errors to the user.
##
## Please use [method get_popup] on the singleton instead of modifying the singleton directly.


const DEFAULT_ICONS = {
	ErrorHelper.LogLevel.INFO: preload("uid://cogwqm5agcbxu"),
	ErrorHelper.LogLevel.WARNING: preload("uid://brttfkx8oqqm8"),
	ErrorHelper.LogLevel.ERROR: preload("uid://dvst3otcyqgyr"),
}
const DEFAULT_COLORS = {
	ErrorHelper.LogLevel.INFO: Color.DEEP_SKY_BLUE,
	ErrorHelper.LogLevel.WARNING: Color(1, 0.8, 0),
	ErrorHelper.LogLevel.ERROR: Color(0.92, 0, 0),
}


func _init() -> void:
	hide()


func _ready() -> void:
	get_label().size_flags_horizontal = Control.SIZE_EXPAND_FILL
	get_label().size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	get_label().reparent(%Content)
	
	if get_tree().root.always_on_top:
		always_on_top = true
		grab_focus()


## Set window's title with the given elements seperated by " - "
func set_title_elements(elements: Array[String] = []) -> void:
	# Add the software title so the user know that the error come from this software.
	elements.push_front(
		ProjectSettings.get_setting("application/config/name_localized").get(
			OS.get_locale_language(),
			ProjectSettings.get_setting("application/config/name")
		)
	)
	
	title = " - ".join(elements)


## Change the error icon based on level.
## Return self.
func set_level(level: ErrorHelper.LogLevel) -> ErrorPopup:
	var level_string: String = ErrorHelper.LogLevel.keys()[level].to_lower()
	%Icon.texture = (
		get_theme_icon(level_string)
		if has_theme_icon(level_string) else
		DEFAULT_ICONS[level]
	)
	%Icon.modulate = (
		get_theme_color(level_string)
		if has_theme_color(level_string) else
		DEFAULT_COLORS[level]
	)

	return self


func get_popup() -> ErrorPopup:
	if not visible:
		return self
	
	var new: ErrorPopup = load(scene_file_path).instantiate()
	
	new.hide() # Just in case I forgot to hide it before saving the scene.
	new.visibility_changed.connect(new.auto_free)
	get_tree().root.add_child.call_deferred(new)
	
	return new


func auto_free() -> void:
	if not visible:
		queue_free()
