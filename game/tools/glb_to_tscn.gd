@tool
extends EditorImportPlugin

func _run():
	pass

func import(source_file, save_path, options, platform_variants, gen_files):
	var file = FileAccess.open(source_file, FileAccess.READ)
	if file == null:
		return FAILED
	var mesh = ArrayMesh.new()
	# Fill the Mesh with data read in "file", left as an exercise to the reader.

	var filename = save_path + "." + _get_save_extension()
	return ResourceSaver.save(mesh, filename)
