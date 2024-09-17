@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true

func _run():
	#open_all_level_scenes()
	#set_shading_mode_for_all()
	#set_albedo_for_materials()
	create_npc_scenes()

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
	var material_filename="male_long_tunic.bin_tex"
	var texture_filename="22_male_long_tunic.bin_tex"
	for i in range(19):
		#print(material_directory_path+material_filename+str(i)+".tres")
		#print(texture_directory_path+texture_filename+str(i)+".tga")
		var material = load(material_directory_path+material_filename+str(i)+".tres")
		var texture = load(texture_directory_path+texture_filename+str(i)+".tga")
		material.set_texture(0, texture)
		ResourceSaver.save(material, material_directory_path+material_filename+str(i)+".tres")
	#for levelname in levelnames:
		#var scene_path = "res://game/levels/"+str(levelname)+"/"+str(levelname)+".tscn"

func create_npc_scenes():
	var template = load("res://game/actors/characters/named_characters/character_template/character_template.tscn")
	var directory = "res://game/actors/characters/named_characters"
	for i in ["eglar_thundren", "llewydr_spell_merchant", "rogurin", "azra_nightwielder",\
	 "egrien_stout", "maiq_the_liar", "scared_goblin", "azra_villager", "egrien_stout_merchant",\
	 "makor", "scythe_trainer", "birgitta", "eranthor", "sergeant_bled", "blanden_grizzle",\
	 "eranthos_spell_merchant_trainer", "meya_violet", "sgt_grell", "branson", "general_duvais",\
	 "sissithik", "giradda", "olpac_trailslag", "skelos_undriel", "chef", "goblin_hero",\
	 "penelope", "spiderqueen", "clerk_skye", "goblin_sergeant", "pergan_asuul", "clever_sed",\
	 "gravel_trothgar", "perosius", "tekin", "colleen", "gravel_trothgar_merchant",\
	 "pilgrim_ghost", "teresa_clothgen", "crypt_caretaker", "heather", "pit_fan",\
	 "umbra_keth", "delfran", "helena", "porliss_caith", "volstok_violet", "devron",\
	 "ivgrizt", "priestess_seraphidis", "wendek_freetalker_merchant", "diamond_spider_queen",\
	 "lakvan", "prisoner", "wulfbris", "dominus", "lieutenant_breser", "refugee",\
	 "yelnicin", "dragonstar_citizen", "lieutenant_jolias", "rene_violet", "dragonstar_guard", "rilora"]:
		#print(directory+"/"+i+"/"+i+".tres")
		ResourceSaver.save(template, directory+"/"+i+"/"+i+".tres", 4)
