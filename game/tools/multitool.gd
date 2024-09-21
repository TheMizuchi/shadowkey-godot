@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true
var levelnames = [ \
	"azra", "broken2", "crypt2", "delfhide", \
	"dstar_e", "erthcave", "ffarena", "glaciercrawl", "lothcav", \
	"snowline", "broken1", "crypt1", "crypt3", \
	"drgnfld", "dstar_w", "fearfrst", "ghstpass", "lakvan", \
	"raiders", "stouttp", "twilite"]

#var ids_with_multiple_scripts = [852, 4207, 853, 107, 114, 169, 200,\
 #4212, 104, 106, 118, 280, 282, 205, 207, 222, 257, 261, 277, 3202, 4244,\
 #89, 112, 132, 138, 166, 203, 209, 246, 259, 274, 3201, 105, 140, 163,\
 #164, 170, 175, 262, 271, 901, 3204]

func _run():
	#open_all_level_scenes()
	#set_shading_mode_for_all()
	#set_albedo_for_materials()
	#create_npc_scenes()
	place_placeholders()
	#place_opponents()
	#attach_animations()
	#test_read_entity_data()
	pass

func read_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var result = json.parse_string(content)
	return result

func open_all_level_scenes():
	#levelnames.reverse()
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

func place_placeholders():
	var current_scene = get_scene()
	var scene_name = current_scene.name
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
	var entity_data = read_file("res://game/assets/data/entity_data/"+scene_name+".json")
	var array = []
	for entity in entity_data[scene_name]:
		if entity["type"] == "2":
			array.append(entity)
	for entity in array:
		var new_placeholder = placeholder_scene.instantiate()
		placeholders.add_child(new_placeholder)
		new_placeholder.set_owner(get_scene())
		new_placeholder.name = str(entity["template"])+"_placeholder"
		new_placeholder.scriptname = entity["script"]
		new_placeholder.position.x = float(entity["x"])+64
		new_placeholder.position.y = float(entity["z"])
		new_placeholder.position.z = float(entity["y"])-64
		new_placeholder.rotation.y = -float(entity["turn"]) * ( PI / 127 )

func fix_placeholder_flip():
	var current_scene = get_scene()
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	for child in placeholders.get_children():
		child.position.y -= 1
		child.rotation.y += deg_to_rad(180)
		child.rotation.x = 0
		child.rotation.z = 0

func place_opponents():
	var directory = "res://game/actors/characters/generic_characters/"
	var id_map = {
		207: "ace_archer"
	}
	var current_scene = get_scene()
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	for child in placeholders.get_children():
		var id = int(child.name.split("_")[0])
		if id in id_map.keys():
			var character = id_map[id]
			var character_scene = load(directory+"/"+character+"/"+character+".tscn")
			var character_instance = character_scene.instantiate()
			child.add_child(character_instance)
			character_instance.set_owner(get_scene())

func attach_animations():
	var openscenes = EditorInterface.get_open_scenes()
	var generic_characters_path = "res://game/actors/characters/generic_characters/"
	var dir = DirAccess.open(generic_characters_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		print(file_name)
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				var scene_path = generic_characters_path+file_name+"/"+file_name+".tscn"
				if dir.file_exists(scene_path):
					print(scene_path)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
