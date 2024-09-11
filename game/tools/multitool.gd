@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true

func _run():
	open_all_level_scenes()
	#set_shading_mode_for_all()

func open_all_level_scenes():
	var levelnames = [ \
	"azra", "broken2", "crypt2", "delfhide", \
	"dstar_e", "erthcave", "ffarena", "glaciercrawl", "lothcav", \
	"snowline", "broken1", "crypt1", "crypt3", \
	"drgnfld", "dstar_w", "fearfrst", "ghstpass", "lakvan", \
	"raiders", "stouttp", "twilite"]
	levelnames.reverse()
	var openscenes = EditorInterface.get_open_scenes()
	#for openscene in openscenes:
		#print(openscene)
	for levelname in levelnames:
		var scene_path = "res://game/levels/"+str(levelname)+"/"+str(levelname)+".tscn"
		#print(scene_path)
		if scene_path not in openscenes:
			EditorInterface.open_scene_from_path(scene_path)


func set_shading_mode_for_all():
	var test = get_scene()
	#var meshes = test.get_child(0).get_child(2)
	#for child in meshes.get_children()
	for mesh_node in test.get_children():
		if set_shading_mode:
			mesh_node.mesh.surface_get_material(0).set_shading_mode(1)
		if texture_filtering:
			mesh_node.mesh.surface_get_material(0)\
			.set_texture_filter(0)
	#var test2 = test.get_child(0).mesh.surface_get_material(0)
	#print(test2.set_shading_mode(1))
