class_name ST

## Static class with utility methods
##
## Not all methods and variables are necessarily used, as some are coming
## from my own template.
## [br][br]
## As god objects are a bad practice, all methods here are prown to be moved somewhere else.


## The inial width of the window, as stated in project settings.
## [br][i]Not updated on window resize.
static func get_screen_width() -> int:
	return ProjectSettings.get_setting("display/window/size/viewport_width")

## The inial height of the window, as stated in project settings.
## [br][i]Not updated on window resize.
static func get_screen_height() -> int:
	return ProjectSettings.get_setting("display/window/size/viewport_height")


## Return the given [param vector] rotated to have the same direction as [param target].
static func align(vector: Vector2, target: Vector2) -> Vector2:
	return vector.rotated(vector.angle_to(target))


static func datetime_dict_to_string(datetime: Dictionary) -> String:
	return "{year}-{month}-{day}-{hour}h-{minute}min-{second}s".format(
		{
			year = datetime["year"],
			month = "%02d" % datetime["month"],
			day = "%02d" % datetime["day"],
			hour = "%02d" % datetime["hour"],
			minute = "%02d" % datetime["minute"],
			second = "%02d" % datetime["second"],
		}
	)
