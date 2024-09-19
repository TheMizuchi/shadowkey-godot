@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true

func _run():
	#open_all_level_scenes()
	#set_shading_mode_for_all()
	#set_albedo_for_materials()
	#create_npc_scenes()
	#place_npcs()
	fix_placeholder_flip()

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

func set_albedo_for_materials():
	var material_directory_path = "res://game/assets/texture_materials/"
	var texture_directory_path = "res://game/assets/textures/"
	var material_filename="male_short_tunic_tex"
	var texture_filename="23_male_short_tunic.bin_tex"
	for i in range(13):
		#print(material_directory_path+material_filename+str(i)+".tres")
		#print(texture_directory_path+texture_filename+str(i)+".tga")
		var material = load(material_directory_path+material_filename+str(i)+".tres")
		var texture = load(texture_directory_path+texture_filename+str(i)+".tga")
		material.set_texture(0, texture)
		ResourceSaver.save(material, material_directory_path+material_filename+str(i)+".tres")
	#for levelname in levelnames:
		#var scene_path = "res://game/levels/"+str(levelname)+"/"+str(levelname)+".tscn"

func create_npc_scenes():
	var template = load("res://game/actors/characters/character_placeholders/test.tscn")# as PackedScene
	var directory = "res://game/actors/characters/character_placeholders"
	for i in range(2):
		#print(directory+"/"+i+"/"+i+".tres")
		var error = ResourceSaver.save(template, directory+"/"+str(i)+".tscn")
		if error:
			print(error)

func place_npcs():
	var current_scene = get_scene()
	var placeholder_scene = load("res://game/tools/placeholder.tscn")
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	if not placeholders:
		var new_parent = Node3D.new()
		new_parent.name = "placeholders"
		actors.add_child(new_parent)
		new_parent.set_owner(current_scene)
		placeholders = actors.get_node("placeholders")
	#nuke previous
	for child in placeholders.get_children():
		placeholders.remove_child(child)
	var array = [
		[105, -25.5, 0.5, 120.5, 0],
		[105, -5.4296875, 0.5, 13.765625, 4],
		[105, -36.5, 0.5, 6.5, 0],
		[105, -49.5, 0.5, 84.5, 0],
		[105, -52.5, 0.5, 88.5, 0],
		[105, -100.5, 0.5, 38.5, -1],
		[105, -110.5, 0.5, 38.5, -2],
		[105, -94.5, 0.5, 12.5, 1],
		[105, -76.5, 0.5, 59.5, -1],
		[103, -46.5, 0.5, 5.5, 0],
		[103, -40.5, 0.5, 25.5, 0],
		[103, -27.5, 0.5, 87.5, 0],
		[103, -95.5, 0.5, 109.5, 0],
		[103, -24.546875, 0.5, 44.2734375, -82],
		[103, -5.48046875, 0.5, 41.375, 32],
		[103, -107.5, 0.5, 14.5, -1],
		[103, -102.5, 0.5, 11.5, 1],
		[103, -67.5, 0.5, 38.5, 1],
		[103, -61.5, 0.5, 38.5, 1],
		[103, -54.5, 0.5, 68.5, -3],
		[175, -64.5, 0.5, 4.859375, 0],
		[173, -96.0625, 0.5, 83.28125, 35],
		[176, -20.75, 0.5, 66.5, -5],
		[176, -21.5, 0.5, 59.5, -4],
		[3202, -70.359375, 0.5, 109.640625, -38],
		[104, -112.5, 0.5, 67.5, 0],
		[104, -122.28125, 0.5, 59.546875, 0],
		[104, -112.5, 0.5, 57.5, 0],
		[104, -62.5, 0.5, 55.5, -4],
		[104, -68.5, 0.5, 54.5, -1],
		[104, -65.5, 0.5, 51.5, -1],
		[104, -49.5, 0.5, 59.5, -4],
		[104, -60.5, 0.5, 76.5, -2],
		[104, -64.5, 0.5, 70.5, -2],
		[104, -78.5, 0.5, 67.5, -2],
		[104, -84.5, 0.5, 12.5, 1],
		[104, -108.328125, 0.5, 9.84375, -2],
		[104, -107.15625, 0.5, 6.234375, -2],
		[104, -100.203125, 0.5, 7.234375, -2],
		[3203, -101.203125, 0.5, 26.046875, 66],
		[3203, -99.5, 0.5, 42.765625, 45],
		[104, -122.5, 0.5, 79.75, -40],
		[104, -10.3515625, 0.5, 43.5, -15],
		[104, -20.46484375, 0.5, 41.328125, -10],
		[104, -13.8359375, 0.5, 25.609375, -3],
		[104, -4.52734375, 0.5, 29.8515625, -117],
		[104, -26.4296875, 0.5, 28.01171875, 32],
		[118, -22.60546875, 0.5, 14.10546875, -10],
		[118, -13.9375, 0.5, 15.1171875, 1],
		[118, -82.5, 0.5, 113.5, 0],
		[118, -89.5, 0.5, 109.5, 0],
		[104, -113.5625, 0.5, 112.5, 0],
		[104, -32.5, 0.5, 78.5, 0],
		[104, -40.5, 0.5, 80.5, -1],
		[104, -36.5, 0.5, 72.5, -2],
		[104, -31.5, 0.5, 30.56640625, -62],
		[104, -41.5, 0.5, 29.5, 0],
		[104, -31.5, 0.5, 27.6875, -49],
		[104, -40.5, 0.5, 89.5, 0],
		[104, -44.5, 0.5, 86.5, 0],
		[118, -21.5, 0.5, 117.5, 0],
		[118, -22.546875, 0.5, 122.5, 0],
		[103, -64.5, 1.5, 62.5, -6],
		[104, -122.5, 0.5, 62.5, 0]
	]
	for entity in array:
		var new_placeholder = placeholder_scene.instantiate()
		placeholders.add_child(new_placeholder)
		new_placeholder.set_owner(get_scene())
		new_placeholder.name = str(entity[0])+"_placeholder"
		new_placeholder.position.x = entity[1]+64
		new_placeholder.position.y = entity[2]+1
		new_placeholder.position.z = entity[3]-64
		new_placeholder.rotation.y = -entity[4] * ( PI / 127 )

func fix_placeholder_flip():
	var current_scene = get_scene()
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	for child in placeholders.get_children():
		child.position.y -= 1
		child.rotation.y += deg_to_rad(180)
		child.rotation.x = 0
		child.rotation.z = 0
