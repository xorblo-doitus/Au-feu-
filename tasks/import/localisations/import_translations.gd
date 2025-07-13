@tool
extends EditorScript


func is_translation(path: String) -> bool:
	return path.get_extension() == "translation"


func _run() -> void:
	print("====================================\nImporting all translations...")
	var found: PackedStringArray = RecursiveDirAccess.new(
		"res://"
	).get_files().filter(is_translation)
	
	if found:
		print("Following translations found:")
		print(" - " + "\n - ".join(found))
		
		ProjectSettings.set_setting("internationalization/locale/translations", found)
		ProjectSettings.save()
		
		print_rich(
			"[color=00aa00]All translations files ("
			+ str(len(found))
			+ ") where added to ProjectSettings."
		)
	else:
		print_rich("[color=cc8800]No translation file found.")
 
