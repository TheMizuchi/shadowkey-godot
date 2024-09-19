@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true

func _run():
	#open_all_level_scenes()
	#set_shading_mode_for_all()
	#set_albedo_for_materials()
	#create_npc_scenes()
	place_npcs()
	#fix_placeholder_flip()

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
		[89, -1.5, -17.125, 94.5, 0],
		[89, -1.5, -19.125, 110.5, -65],
		[106, -68.5, -17.28125, 49.5, 0],
		[106, -114.37109375, -10.5, 16.234375, -66],
		[106, -37.5, -20.390625, 30.06640625, 0],
		[106, -43.140625, -18, 18.23046875, 0],
		[106, -49.640625, -18.94140625, 27.15625, 0],
		[106, -69.5, -17.33203125, 31.35546875, -3],
		[106, -24.5, -29.46875, 108.47265625, -56],
		[106, -18.5, -28.59375, 108.5, 59],
		[106, -21.15625, -28.5390625, 115.328125, 121],
		[106, -117.5, -29.5, 115.5, -4],
		[106, -81.5, -29.5, 87.5, 0],
		[106, -52.5, -25.875, 94.5, 0],
		[106, -54.5, -25.875, 94.5, 1],
		[106, -17.5, -20.125, 6.5, 0],
		[106, -10.5, -22.5, 8.5, 0],
		[106, -9.5, -21.96875, 13.5, 0],
		[112, -68.5, -17.5, 9.5, 22.5],
		[112, -1.5, -18.625, 111.5, 90],
		[138, -1.5, -18.4375, 96.5, -111],
		[138, -1.5, -19.625, 109.5, -125],
		[166, -107.5, -29.09375, 97.5, 94],
		[167, -120.9375, -10.5, 16.5, -69.5],
		[168, -118.5, -10.5, 33.5, 76],
		[169, -1.5, -17.25, 100.5, 124],
		[169, -1.5, -17.625, 99.5, 34],
		[169, -1.5, -17.9375, 98.5, -66],
		[169, -1.5, -18.1875, 97.5, 0],
		[169, -1.5, -17.8125, 102.5, 81],
		[170, -1.5, -17.9375, 95.5, -15],
		[202, -16.5, -29.46875, 81.5, 1],
		[202, -112.0703125, -16.95703125, 58.9765625, 0],
		[202, -122.5, -16.16015625, 58.3828125, 120],
		[202, -96.328125, -10.5, 27.328125, 83],
		[202, -117.828125, -17.48046875, 58.140625, 61],
		[202, -94.5625, -17.0390625, 60.5, 0],
		[202, -84.5, -30.625, 53.5, -25],
		[202, -68.640625, -17.16796875, 53.4609375, 0],
		[202, -11.5625, -25.546875, 52.921875, -5],
		[202, -89.5, -17.44921875, 43.140625, -1],
		[202, -103.8984375, -14.5, 44.33203125, 99],
		[202, -104.26953125, -17.25, 60.765625, 64],
		[202, -103.109375, -14.48828125, 29.5, 23],
		[202, -76.5, -17.5, 18.5, -5],
		[202, -82.5, -17.5, 18.21875, -5],
		[202, -88.0078125, -16, 17.0390625, -3],
		[202, -83.12109375, -17.5, 27.10546875, -5],
		[202, -6.5, -20.03125, 37.5, -6],
		[202, -70.42578125, -17.5, 34.35546875, -3],
		[202, -18.5, -21.546875, 32.71875, -6],
		[202, -14.5625, -23.1875, 20.46875, -5],
		[202, -41.7890625, -26.375, 122.1484375, 99],
		[202, -38.8671875, -27.28125, 119.34765625, 100],
		[202, -70.859375, -29.0703125, 112.546875, 26],
		[202, -46, -29, 118.578125, 101],
		[202, -84.5, -29.5, 89.5, 1],
		[202, -114.5, -29.5, 117.5, -4],
		[202, -109.5, -24.21875, 80.5, 0],
		[202, -117.5, -22.59375, 87.5, 0],
		[202, -63.5, -24.9375, 74.5, -1],
		[202, -44.5, -29.40625, 75.5, -2],
		[202, -36.5, -26, 58.5, -2],
		[202, -96.5, -29.375, 115.5, -5],
		[202, -108.5, -29.90625, 102.5, 102],
		[202, -106.9375, -29.25, 100.5, 102],
		[204, -83.92578125, -17.44140625, 6.60546875, -1]
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
