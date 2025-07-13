class_name RecursiveDirAccess
extends RefCounted


## Provides recursive browsing of the file system.

# Possible upgrades :
# - Pattern matching
# - Directory excluding to ignore whole branches (more efficient than post filtering)


## The root path from wich every subdirectory will be scanned.
var dir_path: String
## See [member DirAccess.include_hidden].
var include_hidden: bool = false
## If true ignore directories starting with a dot (eg. ".git",
## ".godot") and folders containing a ".gdignore" file.
var mimic_editor_ignore: bool = true


func _init(_dir_path, ) -> void:
	dir_path = _dir_path


## Set [member dir_path] and return self.
func set_dir_path(new: String) -> RecursiveDirAccess:
	dir_path = new
	return self


## Set [member include_hidden] and return self.
func set_include_hidden(new: bool) -> RecursiveDirAccess:
	include_hidden = new
	return self


## Set [member mimic_editor_ignore] and return self.
func set_mimic_editor_ignore(new: bool) -> RecursiveDirAccess:
	mimic_editor_ignore = new
	return self


## Search recursively for all files in a directory.
func get_files() -> Array[String]:
	var to_check: Array[String] = [dir_path]
	var result: Array[String] = []
	
	while to_check:
		var path: String = to_check.pop_back()
		
		if mimic_editor_ignore and path.begins_with("."):
			continue
		
		var dir: DirAccess = DirAccess.open(path)
		var error: int = DirAccess.get_open_error()
		
		if error:
			ErrorHelper.new("DirAccess.open() failed", "Tried to open: " + path).set_godot_builtin_error(error).popup()
		else:
			if mimic_editor_ignore and dir.file_exists(".gdignore"):
				continue
			
			dir.include_hidden = include_hidden
			
			for dir_name in dir.get_directories():
				to_check.append(path.path_join(dir_name))
			for file_name in dir.get_files():
				result.append(path.path_join(file_name))

	return result
