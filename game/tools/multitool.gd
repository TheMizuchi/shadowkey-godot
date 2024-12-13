@tool
extends EditorScript

var set_shading_mode = true
var texture_filtering = true
var levelnames = [
	"azra", "broken2", "crypt2", "delfhide",
	"dstar_e", "erthcave", "ffarena", "glaciercrawl", "lothcav",
	"snowline", "broken1", "crypt1", "crypt3",
	"drgnfld", "dstar_w", "fearfrst", "ghstpass", "lakvan",
	"raiders", "stouttp", "twilite"
]

var y_offset_map = {
	"erthcave": -13.778,
	"crypt1": -6.8,
	"twilite": -6.9,
	"delfhide": -35
}

var model_map = {
	140: "140_fortifyingcrystal", 142: "142_spiketrap", 18: "18_rat",
	20: "20_female_long_tunic", 21: "21_female_short_tunic", 22: "22_male_long_tunic",
	230: "230_Pergan02", 233: "233_azra", 23: "23_male_short_tunic", 53: "53_delfran",
	55: "55_spider", 56: "56_wormmouth", 58: "58_spiderqueen", 59: "59_argonian",
	60: "60_ghost", 61: "61_goblin", 62: "62_hunger", 63: "63_orc_ice_warrior",
	64: "64_jelly", 65: "65_kagouti", 66: "66_snowray", 67: "67_umbra",
	68: "68_wolf", 69: "69_zombie", 70: "70_portcullis", 78: "78_sarcophagus"
}

# model_id: [entity IDs which use that model],
var id_model_map = {
	18: [202, 203, 204, 225, 253, 275],
	20: [90, 165, 167, 168, 169, 170, 219, 292, 293, 852, 1900, 1901],
	21: [164, 166, 217, 256, 4001],
	22: [91, 106, 112, 114, 118, 138, 171, 179, 206, 207, 209, 220, 228, 229, 230,\
	231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 250,\
	267, 270, 278, 280, 281, 282, 283, 287, 853, 1907, 1909, 1910, 4105, 4108, 4160, 4161],
	23: [107, 142, 163, 172, 174, 178, 211, 212, 213, 221, 222, 251, 279, 284, 285, 290,\
	854, 2000, 4107, 4207, 4208, 4212, 4244, 4257, 5152],
	53: [109, 255, 1906, 4030, 4109],
	55: [132, 205, 265],
	56: [200, 252, 254, 926],
	58: [134],
	59: [140, 262, 286, 3200],
	60: [131, 258, 921, 3201, 4243, 5201],
	61: [173, 900, 901, 3202, 4202, 5151],
	62: [264, 272, 924, 925, 3203],
	63: [139, 214, 224, 226, 227, 246, 249, 271, 1905, 3204, 3206, 4228, 5150],
	64: [247, 259, 261, 269, 3205],
	65: [218, 257, 277],
	66: [216, 260, 263, 3207],
	67: [274, 3208, 4299],
	68: [208, 223, 273, 291, 922, 1908, 3209, 4003, 4210],
	69: [103, 104, 105, 176, 177, 3210],
	140: [1015],
	230: [175, 4400],
	233: [89]
}

# TODO: figure out how to handle case ("Monsters" and "monsters")
var scriptmap = {
	"monsters\\Bandit_Thug.s" : "bandit_thug",
	"monsters\\Assault_Rat.s" : "",
#region scriptmap_tldr
	"monsters\\Goblin.s" : "goblin",
	"monsters\\shardwolf.s" : "shardwolf",
	"monsters\\Bandit_Brawler.s" : "bandit_brawler",
	"monsters\\Bandit_Mage.s" : "bandit_mage",
	"monsters\\spider_savager.s" : "spider_savager",
	"monsters\\Umbric_Rats.s" : "",
	"monsters\\Ace_Archer.s" : "ace_archer",
	"monsters\\Nightdead.s" : "nightdead",
	"monsters\\raider.s" : "raider",
	"monsters\\Raider.s" : "raider",
	"monsters\\Azra_Zombie.s" : "",
	"monsters\\Azra_Rat.s" : "azra_rat",
	"monsters\\Spire_Thief.s" : "spire_thief",
	"monsters\\Cave_Spider.s" : "cave_spider",
	"monsters\\Ill_Floater.s" : "ill_floater",
	"monsters\\Skyrim_Soldier.s" : "skyrim_soldier",
	"monsters\\Shriekfloater.s" : "shriekfloater",
	"monsters\\Shadow_Ghast.s" : "shadow_ghast",
	"monsters\\Tharnblade.s" : "tharnblade",
	"monsters\\Skyrim_Archer.s" : "skyrim_archer",
	"monsters\\Highwaymage.s" : "highwaymage",
	"monsters\\Nubbed_Wormmouth.s" : "nubbed_wormmouth",
	"monsters\\Horrid_Wormmouth.s" : "horrid_wormmouth",
	"monsters\\Arrow_Shade.s" : "arrow_shade",
	"monsters\\Flesh_Defiler.s" : "flesh_defiler",
	"monsters\\Bandit_Swordsman.s" : "bandit_swordsman",
	"monsters\\Shadow_Tentacle.s" : "shadow_tentacle",
	"monsters\\shadow_tentacle.s" : "shadow_tentacle",
	"lakvan\\Deadeye.s" : "deadeye",
	"monsters\\Sergeant.s" : "sergeant",
	"broken1\\mob_Spire_Archer.s" : "mob_spire_archer",
	"monsters\\sgoblin.s" : "sgoblin",
	"dstar_e\\DSE_Skyrim_Soldier.s" : "dse_skyrim_soldier",
	"monsters\\wormmouth.s" : "wormmouth",
	"monsters\\Wormmouth.s" : "wormmouth",
	"monsters\\Cavern_Stinger.s" : "cavern_stinger",
	"monsters\\Dusk_Wolves.s" : "dusk_wolves",
	"monsters\\Tharn_Archer.s" : "tharn_archer",
	"monsters\\Dire_Wolf.s" : "dire_wolf",
	"monsters\\Archer.s" : "archer",
	"monsters\\Ice_Scout.s" : "ice_scout",
	"monsters\\Icebowman.s" : "icebowman",
	"monsters\\Shadowray.s" : "shadowray",
	"monsters\\Deadeye.s" : "deadeye",
	"dstar_e\\DSE_Dragonstar_Guard.s" : "dse_dragonstar_guard",
	"monsters\\Tunnel_Wight.s" : "tunnel_wight",
	"monsters\\tunnel_wight.s" : "tunnel_wight",
	"monsters\\Sting_Floater.s" : "sting_floater",
	"dstar_e\\DSE_Skyrim_Archer.s" : "dse_skyrim_archer",
	"monsters\\mountain_wight.s" : "mountain_wight",
	"monsters\\Mountain_Wight.s" : "mountain_wight",
	"monsters\\Spider_Guardian.s" : "spider_guardian",
	"monsters\\Clawrunner.s" : "clawrunner",
	"dstar_e\\DSE_Dragonstar_Archer.s" : "dse_dragonstar_archer",
	"monsters\\Elite_Bowman.s" : "elite_bowman",
	"monsters\\Spire_Archer.s" : "spire_archer",
	"monsters\\Twilight_Wolf.s" : "twilight_wolf",
	"monsters\\Ancestor_Ghost.s" : "ancestor_ghost",
	"GlcrCrwl\\Blizzard_Warrior.s" : "blizzard_warrior",
	"monsters\\Savage_Bounder.s" : "savage_bounder",
	"dstar_w\\raider_Q37.s" : "",
	"arat.s" : "",
	"monsters\\Wickeder.s" : "",
	"dstar_w\\Ace_Archer_Q37.s" : "",
	"Raiders\\GLD_Wickeder.s" : "",
	"dstar_w\\F_Citizen_Fine.s" : "",
	"dstar_w\\F_Citizen.s" : "",
	"twilite\\INV_Zombie_Dusk.s" : "",
	"monsters\\Villager_Prisoner.s" : "",
	"monsters\\Snowray.s" : "",
	"dstar_e\\Pitfans.s" : "",
	"dstar_e\\Prisoner.s" : "",
	"dstar_w\\M_Citizen_Fine.s" : "",
	"monsters\\Highwayman.s" : "",
	"monsters\\Bandit_Mage_Q37.s" : "",
	"lakvan\\Bandit_Thug_Cskye.s" : "",
	"Raiders\\Red_Spider.s" : "",
	"Raiders\\BLU_Spiders.s" : "",
	"drgnfld\\Ace_Archer_Q31.s" : "",
	"Raiders\\Red_Wickeder.s" : "",
	"Raiders\\BLU_Wickeder.s" : "",
	"dstar_w\\M_Citizen.s" : "",
	"broken1\\mob_Dire_Wolf.s" : "",
	"broken1\\mob_Tharn_Archer.s" : "",
	"fearfrst\\Ivgrizt_Goblins.s" : "",
	"drgnfld\\raider_Q31.s" : "",
	"monsters\\Azra_InCrossing.s" : "",
	"crypt1\\Azra_Zombie_Q65.s" : "",
	"cryptsh3\\m2_night_dead.s" : "",
	"delfhide\\dh_guard_talk.s" : "",
	"drgnfld\\Bandit_Thug_Q31.s" : "",
	"monsters\\Bandit_Thug_Q37.s" : "",
	"monsters\\Old_Trinket.s" : "",
	"drgnfld\\Bandit_Mage_Q31.s" : "",
	"monsters\\Skelos_Undriel_Azra.s" : "",
	"delfhide\\heather.s" : "",
	"monsters\\Villager_Prisoner1.s" : "",
	"monsters\\Villager_Prisoner2.s" : "",
	"monsters\\Villager_Prisoner3.s" : "",
	"monsters\\Villager_Prisoner4.s" : "",
	"twilite\\INV_Zombie_Dawn.s" : "",
	"Raiders\\GLD_Spider.s" : "",
	"dstar_e\\Thief_Ace_Archer.s" : "",
	"cryptsh3\\m1_arrow_shade.s" : "",
	"dstar_e\\DragonStar_G.s" : "",
	"monsters\\Dragonstar_Guard.s" : "",
	"dstar_w\\east_guard.s" : "",
	"Raiders\\GLD_Bounder.s" : "",
	"cryptsh3\\m1_shriekfloater.s" : "",
	"dstar_e\\Thief_Raider.s" : "",
	"dstar_e\\M_SkyrimHQ.s" : "",
	"crypt1\\Azra.s" : "",
	"ffarena\\Azra.s" : "",
	"erthcave\\Azra_Zombie.s" : "",
	"twilite\\Volstok_Violet.s" : "",
	"delfhide\\lt_jolais.s" : "",
	"monsters\\Chef.s" : "",
	"monsters\\Blanden_Grizzle.s" : "",
	"delfhide\\Bandit_Thug.s" : "bandit_thug",
	"delfhide\\lt_breser.s" : "",
	"delfhide\\Delfran.s" : "",
	"dstar_e\\Old_Trinket.s" : "",
	"stouttp\\OldTrinket.s" : "",
	"delfhide\\sgt_grell.s" : "",
	"delfhide\\archer_guard.s" : "",
	"lakvan\\Highwaymage.s" : "highwaymage",
	"spider.s" : "",
	"monsters\\Diamond_Spider_Queen.s" : "",
	"monsters\\Skelos_Undriel.s" : "",
	"monsters\\Skelos_Undriel_ET.s" : "",
	"monsters\\Olpac_Trailslag.s" : "",
	"dstar_w\\Porliss_Caith2.s" : "",
	"monsters\\Porliss_Caith.s" : "",
	"monsters\\Clever_Sed.s" : "",
	"dstar_e\\Thief_Trainer.s" : "",
	"monsters\\Penelope.s" : "",
	"dstar_e\\Girrada.s" : "",
	"monsters\\Seraphidis.s" : "",
	"monsters\\Tanyin_Aldwyr_Azra.s" : "",
	"dstar_e\\Tanyin_Aldwyr.s" : "",
	"monsters\\Tanyin_Aldwyr.s" : "",
	"monsters\\Acolyte_Menlin.s" : "",
	"monsters\\Priestess_Almathea.s" : "",
	"monsters\\BirgiddaAzra.s" : "",
	"monsters\\Birgidda.s" : "",
	"erthcave\\rogurin.s" : "",
	"monsters\\Ivgrizt.s" : "",
	"dstar_w\\Volstok_Violet.s" : "",
	"lakvan\\Pergan_Asuul.s" : "",
	"twilite\\Pergan_Asuul.s" : "",
	"lakvan\\Highwaymage_Cskye.s" : "",
	"ratherb.s" : "",
	"cryptsh3\\m2_arrow_shade.s" : "",
	"monsters\\Clerk_Skye.s" : "",
	"dstar_e\\Monster03.s" : "",
	"monsters\\Glacier_Captain.s" : "",
	"glcrcrwl\\icebowman.s" : "icebowman",
	"glcrcrwl\\Icebowman_special.s" : "",
	"monsters\\makor_.s" : "",
	"monsters\\Rilora.s" : "",
	"Raiders\\Red_Bounder.s" : "",
	"Raiders\\BLU_Bounder.s" : "",
	"crypt1\\Shriekfloater_Q65.s" : "",
	"crypt1\\Shriekfloater_Special.s" : "",
	"monsters\\Yelnicin.s" : "",
	"monsters\\Sisithik.s" : "",
	"monsters\\Soul_Shredder.s" : "",
	"broken1\\bled.s" : "",
	"nullspeedncequer.s" : "",
	"nullpersonalitysuul_Crypt2.s" : "",
	"monsters\\Umbra_Keth.s" : "",
	"dstar_e\\Dolic.s" : "",
	"dstar_e\\Trent.s" : "",
	"dstar_w\\refugee_bread0.s" : "",
	"dstar_w\\refugee_bread2.s" : "",
	"dstar_w\\refugee_bread3.s" : "",
	"dstar_w\\refugee_balm.s" : "",
	"dstar_e\\Uwa.s" : "",
	"dstar_e\\Hasturt.s" : "",
	"dstar_w\\refugee_money0.s" : "",
	"dstar_w\\refugee_money1.s" : "",
	"dstar_w\\refugee_money2.s" : "",
	"dstar_w\\refugee_talk.s" : "",
	"monsters\\Wulfbris.s" : "",
	"monsters\\Devron.s" : "",
	"monsters\\Eglar_Thundren.s" : "",
	"monsters\\Branson.s" : "",
	"monsters\\Teresa.s" : "",
	"monsters\\Colleen.s" : "",
	"dstar_e\\Wylia.s" : "",
	"dstar_e\\Yvette.s" : "",
	"dstar_e\\Cure01.s" : "",
	"dstar_e\\Money10.s" : "",
	"dstar_e\\Bread01.s" : "",
	"dstar_e\\Talk01.s" : "",
	"dstar_e\\Cure02.s" : "",
	"dstar_e\\Money11.s" : "",
	"dstar_e\\Money12.s" : "",
	"dstar_w\\refugee_talk1.s" : "",
	"dstar_w\\refugee_bread1.s" : "",
	"dstar_w\\F_Citizen_talkmenu.s" : "",
	"dstar_w\\F_Citizen_Cure02.s" : "",
	"dstar_w\\F_Citizen_talkmenu2.s" : "",
	"dstar_w\\F_Citizen_Bread01.s" : "",
	"dstar_w\\refugee_money3.s" : "",
	"dstar_w\\F_Citizen_Money02.s" : "",
	"dstar_w\\F_Citizen_Cure.s" : "",
	"dstar_e\\Dominus.s" : "",
	"dstar_e\\Pit_Boss.s" : "",
	"dstar_e\\Talk02.s" : "",
	"dstar_e\\Bread03.s" : "",
	"dstar_w\\refugee_bread4.s" : "",
	"dstar_w\\M_Citizen_talkmenu.s" : "",
	"dstar_w\\M_Citizen_Money01.s" : "",
	"dstar_w\\M_Citizen_Bread02.s" : "",
	"dstar_w\\M_Citizen_Bread03.s" : "",
	"dstar_w\\M_Citizen_GoAway.s" : "",
	"monsters\\Goblin_Hero.s" : "",
	"fearfrst\\Sergeant.s" : "sergeant",
	"lothna\\fortifyingcrystal.s" : "",
	"monsters\\Helena.s" : "",
	"monsters\\Meya_Violet.s" : "",
	"broken2\\Perosius_temp.s" : "",
	"broken1\\mob_Tharnblade.s" : "",
	"monsters\\Crypt_Caretaker.s" : "",
	"cryptsh3\\m2_ancestor_ghost.s" : "",
	"lothna\\pilgrim_ghost.s" : "",
	"fearfrst\\Ivgrizt.s" : "",
	"twilite\\goblin_talk.s" : "",
	"glcrcrwl\\chieftan.s" : "",
	"monsters\\Weak_Makor.s" : "",
	"ghstpass\\violet.s" : "",
	"monsters\\Duvais.s" : "",
	"monsters\\lakvan.s" : "",
	"dstar_e\\Monster01.s" : "",
	"dstar_e\\Monster05.s" : "",
	"Raiders\\Raider_Enter.s" : "",
	"Raiders\\Raider_loot3.s" : "",
	"Raiders\\Raider_loot4.s" : "",
	"Raiders\\Raider_loot5.s" : "",
	"Raiders\\DrunkRaider.s" : "",
	"dstar_e\\Monster02.s" : "",
	"dstar_e\\Monster04.s" : "",
	"dstar_e\\M_SkyrimHQ_Watch.s" : "",
	"dstar_e\\M_SkyrimHQ_Ace.s" : "",
	"monsters\\Pergan_Asuul_Crypt2.s" : "",
	"Monsters\\Bandit_Mage_Q37.s" : "",
	"Monsters\\Bandit_Thug_Q37.s" : "",
	"Monsters\\Bandit_Brawler.s" : "bandit_brawler",
#endregion
	"Monsters\\Archer.s" : "archer",
	"Monsters\\Bandit_Mage.s" : "bandit_mage",
	"Monsters\\Bandit_Thug.s" : "bandit_thug"
}

var makelist = {
	"bandit_thug" : [23,8,5,1,6],
#region old_makelist
	"goblin" : [61,0,1,2,3],
	"shardwolf" : [68,0,1,2,3],
	"bandit_brawler" : [22,8,5,1,6],
	"bandit_mage" : [22,8,5,3,6],
	"spider_savager" : [55,0,1,2,3],
	"ace_archer" : [22,8,5,2,6],
	"nightdead" : [69,0,1,2,3],
	"raider" : [23,8,5,1,6],
	"azra_rat" : [18,0,1,2,3],
	"spire_thief" : [22,8,5,1,6],
	"cave_spider" : [55,0,1,2,3],
	"ill_floater" : [64,0,1,2,3],
	"skyrim_soldier" : [23,8,5,1,6],
	"shriekfloater" : [64,0,1,2,3],
	"shadow_ghast" : [60,0,1,2,3],
	"tharnblade" : [63,8,5,1,6],
	"skyrim_archer" : [23,8,5,2,6],
	"highwaymage" : [22,8,5,3,6],
	"nubbed_wormmouth" : [56,0,1,2,3],
	"horrid_wormmouth" : [56,0,1,2,3],
	"arrow_shade" : [22,8,5,2,6],
	"flesh_defiler" : [69,0,1,2,3],
	"bandit_swordsman" : [22,8,5,1,6],
	"shadow_tentacle" : [64,0,1,2,3],
	"sergeant" : [61,0,1,2,3],
	"mob_spire_archer" : [22,8,5,2,6],
	"sgoblin" : [61,0,1,2,3],
	"dse_skyrim_soldier" : [23,8,5,1,6],
	"wormmouth" : [56,0,1,2,3],
	"cavern_stinger" : [66,0,1,2,3],
	"dusk_wolves" : [68,0,1,2,3],
	"tharn_archer" : [22,8,5,2,6],
	"dire_wolf" : [68,0,1,2,3],
	"archer" : [22,8,5,2,6],
	"ice_scout" : [63,8,5,1,6],
	"icebowman" : [63,8,5,2,6],
	"shadowray" : [66,0,1,2,3],
	"deadeye" : [22,8,5,2,6],
	"dse_dragonstar_guard" : [23,8,5,1,6],
	"tunnel_wight" : [62,0,1,2,3],
	"sting_floater" : [64,0,1,2,3],
	"dse_skyrim_archer" : [23,8,5,2,6],
	"mountain_wight" : [62,0,1,2,3],
	"spider_guardian" : [55,0,1,2,3],
	"clawrunner" : [65,0,1,2,3],
	"dse_dragonstar_archer" : [23,8,5,2,6],
	"elite_bowman" : [63,8,5,2,6],
	"spire_archer" : [22,8,5,2,6],
	"twilight_wolf" : [68,0,1,2,3],
	"ancestor_ghost" : [60,0,1,2,3],
	"blizzard_warrior" : [63,8,5,1,6],
#endregion
	"savage_bounder" : [65,0,1,2,3]
}


func _run():
	#open_all_level_scenes()
	#set_shading_mode_for_all()
	#set_albedo_for_materials()
	#create_character_scenes_from_entity_data()
	
	#place_placeholders()
	#place_characters()
	reparent_placeholder_characters()
	#nodecount()
	pass

func read_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var result = json.parse_string(content)
	return result

func list_subdirectories(path):
	var result = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				result.append(file_name)
			file_name = dir.get_next()
	return result

func nodecount():
	var current_scene = get_scene()
	var node = current_scene.get_node("actors/opponents")
	print(node.get_child_count())

func open_all_level_scenes():
	#levelnames.reverse()
	var openscenes = EditorInterface.get_open_scenes()
	for levelname in levelnames:
		var scene_path = "res://game/levels/"+str(levelname)+"/"+str(levelname)+".tscn"
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

func place_placeholders():
	var current_scene = get_scene()
	var scene_name = current_scene.name
	var character_marker_scene = load("res://game/tools/character_position_marker.tscn")
	var object_marker_scene = load("res://game/tools/object_position_marker.tscn")
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	var offset = 64
	if scene_name == "ffarena":
		offset = 32
	if not placeholders:
		var new_parent = Node3D.new()
		new_parent.name = "placeholders"
		actors.add_child(new_parent)
		new_parent.set_owner(current_scene)
		if scene_name in y_offset_map.keys():
			new_parent.position.y = y_offset_map[scene_name]
		placeholders = actors.get_node("placeholders")
	#nuke previous
	for child in placeholders.get_children():
		placeholders.remove_child(child)
	var entity_data = read_file("res://game/assets/data/entity_data/"+scene_name+".json")
	for entity in entity_data[scene_name]:
		var new_placeholder
		if entity.type == "2":
			new_placeholder = character_marker_scene.instantiate()
		else:
			new_placeholder = object_marker_scene.instantiate()
		new_placeholder.type = int(entity.type)
		placeholders.add_child(new_placeholder)
		new_placeholder.set_owner(get_scene())
		new_placeholder.name = str(entity["template"])+"_placeholder"
		new_placeholder.scriptname = entity["script"]
		new_placeholder.position.x = float(entity.x)+offset
		new_placeholder.position.y = float(entity.z)
		new_placeholder.position.z = float(entity.y)-offset
		# TODO: figure out correct X and Z rotation logic
		new_placeholder.rotation.x = -float(entity.roll) * ( PI / 127 )
		new_placeholder.rotation.y = -float(entity.turn) * ( PI / 127 )
		new_placeholder.rotation.z = -float(entity.pitch) * ( PI / 127 )
		#new_placeholder.rotation.x += deg_to_rad(180)
		#if entity.type == "2":
		new_placeholder.rotation.y += deg_to_rad(180)
		#new_placeholder.rotation.z += deg_to_rad(180)

func reparent_placeholder_characters():	
	var current_scene = get_scene()
	var actors = current_scene.get_node("actors")
	var opponents = actors.get_node("opponents")
	var placeholders = actors.get_node("placeholders")
	for child in placeholders.get_children():
		var opponent_list = child.get_children()
		#print(opponent_list.size())
		if opponent_list:
			opponent_list[0].reparent(opponents)
			opponent_list[0].name = child.name

func create_character_scenes_from_entity_data():
	var uniq_combos = read_file("res://game/assets/data/uniq_combos.json")
	var function_values_json = read_file("res://game/assets/data/function_values.json")
	var characters_path = "res://game/actors/characters/generated_characters/"
	var bigtest = {}
	# merge dictionary lol wtf
	for i in function_values_json:
		bigtest[i.keys()[0]] = i[i.keys()[0]]

	var i = 0
	for combo in uniq_combos["test"]:
		#filter only to specific entities
		if false:
			if int(combo.id) != 169:
				continue
		var script_lower = combo.script.to_lower()
		var scriptname = script_lower.left(script_lower.length() - 2)
		if scriptname not in bigtest.keys():
			continue
		#var file_name
		#print(bigtest[script_no_s])
		#create_character_scene(character_name, model, skin, idle, walk, attack, death)
		var model_id = 0
		for id in id_model_map:
			if int(combo.id) in id_model_map[id]:
				model_id = id
		var file_name = str(combo.id) + "_" + str(scriptname.replace("\\", "__"))
		print(file_name)
		#print("model: ", model_id, "\tskin: ", bigtest[scriptname].SetSkin)
		#print("idle: ", bigtest[scriptname].SetIdleAnimation, "\t\twalk: ", bigtest[scriptname].SetWalkAnimation)
		#print("attack: ", bigtest[scriptname].SetSwingAnimation, "\tdeath: ", bigtest[scriptname].SetDeathAnimation)
		
		var return_array = generate_character_scene(str(model_id), model_id,\
		bigtest[scriptname].SetSkin, bigtest[scriptname].SetIdleAnimation,\
		bigtest[scriptname].SetWalkAnimation, bigtest[scriptname].SetSwingAnimation,\
		bigtest[scriptname].SetDeathAnimation, bigtest[scriptname].SetAggressive,\
		bigtest[scriptname].SetExpWorth, file_name)
		
		var character_scene = return_array[0]
		var material_scene = return_array[1]
		var material_red = return_array[2]
		
		var packedscene = PackedScene.new()
		packedscene.pack(character_scene)
		ResourceSaver.save(packedscene, characters_path+file_name+"/"+file_name+".tscn")
		
		ResourceSaver.save(material_scene, characters_path+file_name+"/"+file_name+"_material.tres")
		ResourceSaver.save(material_red, characters_path+file_name+"/"+file_name+"_material_red.tres")
		

		if false:
			i += 1
			if i > 20:
				break

func generate_character_scene(character_name, model, skin,\
idle, walk, attack, death, aggressive, expworth, file_name):
	
	var animations_path = "res://game/assets/animations/"
	var template_path
	var template_scene
	if expworth != "" and int(expworth) > 7:
		template_path = "res://game/actors/characters/generic_characters/opponent_template/"
		template_scene = load(template_path+"opponent_template.tscn")
	else:
		template_path = "res://game/actors/characters/generic_characters/character_template/"
		template_scene = load(template_path+"character_template.tscn")
	var generated_characters_path = "res://game/actors/characters/generated_characters/"
	var textures_path = "res://game/assets/textures/"
	var new_scene = template_scene.instantiate()
	var animation_name = model_map[model]
	new_scene.name = character_name

	var material_path = "res://game/actors/characters/generic_characters/character_template/character_material.tres"
	var material_red_path = "res://game/actors/characters/generic_characters/character_template/character_material_red.tres"
	if not skin:
		skin = 0
	var texture_path = textures_path+str(model_map[model])+".bin_tex"+str(skin)+".tga"
	var texture = load(texture_path)
	var original_material = load(material_path)
	var material_scene = original_material.duplicate()
	var original_material_red = load(material_red_path)
	var material_red_scene = original_material_red.duplicate()
	material_scene.set_texture(0, texture)
	material_red_scene.set_texture(0, texture)
	#material_scene.set_texture_filter(0)
	var idle_animation_path = animations_path+animation_name+"/anim"+str(idle)+"/anim"+str(idle)+".tscn"
	var idle_animation
	var idle_instance
	var idle_node = new_scene.get_node("idle")
	if FileAccess.file_exists(idle_animation_path):
		idle_animation = load(idle_animation_path)
		idle_instance = idle_animation.instantiate()
		var idle_frame0 = idle_instance.get_node("frame0")
		var idle_player = idle_instance.get_node("AnimationPlayer")
		idle_frame0.reparent(idle_node)
		idle_frame0.rotation.x = deg_to_rad(90)
		idle_frame0.set_surface_override_material(0, material_scene)
		idle_player.reparent(idle_node)
		idle_frame0.set_owner(new_scene)
		idle_player.set_owner(new_scene)
	else:
		idle_animation = MeshInstance3D.new()
		idle_animation.name = "frame0"
		idle_animation.mesh = load("res://game/assets/obj_models/"+animation_name+".obj")
		idle_animation.set_surface_override_material(0, material_scene)
		idle_node.add_child(idle_animation)
		idle_animation.set_owner(new_scene)
	if expworth != "" and int(expworth) > 7:
		var dict = {"walk": walk, "attack": attack, "death": death}
		for a in dict:
			if dict[a] == "":
				dict[a] = 1
			var animation_scene = load(animations_path+animation_name+\
			"/anim"+str(dict[a])+"/anim"+str(dict[a])+".tscn")
			var animation_instance = animation_scene.instantiate()
			var mesh = animation_instance.get_node("frame0")
			mesh.set_surface_override_material(0, material_scene)
			var animation_player = animation_instance.get_node("AnimationPlayer")
			var node3d = new_scene.get_node(a)
			mesh.hide()
			
			mesh.reparent(node3d)
			mesh.rotation.x = deg_to_rad(90)
			animation_player.reparent(node3d)
			mesh.set_owner(new_scene)
			animation_player.set_owner(new_scene)
	
		new_scene.get_node("paint_red").red_material_path = "res://game/actors/characters/generated_characters/"+file_name+"/"+file_name+"_material_red.tres"
	
	return [new_scene, material_scene, material_red_scene]

func place_characters():
	var generated_characters_path = "res://game/actors/characters/generated_characters/"
	var current_scene = get_scene()
	var actors = current_scene.get_node("actors")
	var placeholders = actors.get_node("placeholders")
	var generated_characters = list_subdirectories(generated_characters_path)
	for child in placeholders.get_children():
		if child.type != 2:
			continue
		var id = child.name.split("_")[0]
		var scriptname_lower = child.scriptname.to_lower().replace("\\", "__")
		var scriptname = scriptname_lower.left(scriptname_lower.length() - 2)
		var id_scritpname = id+"_"+scriptname
		#print(child.scriptname, ": ", scriptmap[child.scriptname])
		var scene_path = generated_characters_path+"/"+id_scritpname+"/"+id_scritpname+".tscn"
		#print(scene_path)
		var character_scene = load(scene_path)
		var character_instance = character_scene.instantiate()
		child.add_child(character_instance)
		character_instance.set_owner(get_scene())

#region archive
#func create_npc_scenes():
	#var template = load("res://game/actors/characters/character_placeholders/test.tscn")# as PackedScene
	#var directory = "res://game/actors/characters/character_placeholders"
	#for i in range(2):
		##print(directory+"/"+i+"/"+i+".tres")
		#var error = ResourceSaver.save(template, directory+"/"+str(i)+".tscn")
		#if error:
			#print(error)

#func fix_placeholder_flip():
#var current_scene = get_scene()
#var actors = current_scene.get_node("actors")
#var placeholders = actors.get_node("placeholders")
#for child in placeholders.get_children():
	#child.position.y -= 1
	#child.rotation.y += deg_to_rad(180)
	#child.rotation.x = 0
	#child.rotation.z = 0
	
#var uniq_combos = []
#for level in levelnames:
	##print("=======================", level, "=======================")
	#var entity_data = read_file("res://game/assets/data/entity_data/"+level+".json")
	#for entity in entity_data[level]:
		#if entity["type"] == "2":
			##print(entity.template, "\t", entity.script)
			#var is_new = true
			#for combo in uniq_combos:
				#if combo[0] == entity.template and combo[1] == entity.script:
					#is_new = false
			#if is_new:
				##print(entity.template, "\t", entity.script)
				#uniq_combos.append([entity.template, entity.script])


#func create_character_scenes():
	##var openscenes = EditorInterface.get_open_scenes()
	#var characters_path = "res://game/actors/characters/unfinished_characters/"
	#var dir = DirAccess.open(characters_path)
	#if dir:
		#dir.list_dir_begin()
		#var file_name = dir.get_next()
		#while (file_name != ""):
			#if dir.current_is_dir():
				#if file_name in makelist.keys():
				##if file_name == "arrow_shade":
					#print(file_name)
					#var script_template = load("res://game/actors/characters/generic_characters/opponent_template/extend.gd")
					#var new_script_path = characters_path+file_name+"/"+file_name+".gd"
					#ResourceSaver.save(script_template, new_script_path)
					#var new_script = load(new_script_path)
					#var character_scene = create_character_scene(file_name,\
					#makelist[file_name][0], 0, makelist[file_name][1],\
					#makelist[file_name][2], makelist[file_name][3],makelist[file_name][4])
					#character_scene.set_script(new_script)
					#var character_material = characters_path+file_name+"/"+file_name+"_material.tres"
					#var material_instance = load(character_material)
					#for animation_name in ["idle", "walk", "attack", "death"]:
						#var frame0 = character_scene.get_node(animation_name+"/frame0")
						#frame0.set_surface_override_material(0, material_instance)
					#var paint_red = character_scene.get_node("paint_red")
					#paint_red.red_material_path = characters_path+file_name+"/"+file_name+"_material_red.tres"
					#var packedscene = PackedScene.new()
					#packedscene.pack(character_scene)
					#ResourceSaver.save(packedscene, characters_path+file_name+"/"+file_name+".tscn")
				#
				##var material = load(template_path+"opponent_material.tres")
				##var material_red = load(template_path+"opponent_material_red.tres")
				##ResourceSaver.save(material, characters_path+file_name+"/"+file_name+"_material.tres")
				##ResourceSaver.save(material_red, characters_path+file_name+"/"+file_name+"_material_red.tres")
			#else:
				#print("Found file: " + file_name)
			#file_name = dir.get_next()
	#else:
		#print("An error occurred when trying to access the path.")
#
#func create_character_scene(character_name, model, skin, idle, walk, attack, death):
	#
	## TODO: lol someone please show me how to use loops for all this repeating code
	#
	#var animations_path = "res://game/assets/animations/"
	#var obj_models_path = "res://game/assets/obj_models/"
	#var textures_path = "res://game/assets/textures/"
	#var template_path = "res://game/actors/characters/generic_characters/opponent_template/"
	#var template_scene = load(template_path+"opponent_template.tscn")
	#var animation_name = model_map[model]
	#var new_scene = template_scene.instantiate()
	#new_scene.name = character_name
	#var idle_animation = load(animations_path+animation_name+"/anim"+str(idle)+"/anim"+str(idle)+".tscn")
	#var walk_animation = load(animations_path+animation_name+"/anim"+str(walk)+"/anim"+str(walk)+".tscn")
	#var attack_animation = load(animations_path+animation_name+"/anim"+str(attack)+"/anim"+str(attack)+".tscn")
	#var death_animation = load(animations_path+animation_name+"/anim"+str(death)+"/anim"+str(death)+".tscn")
	##for animation_scene in [idle_animation, walk_animation, attack_animation, death_animation]:
	#var idle_instance = idle_animation.instantiate()
	#var walk_instance = walk_animation.instantiate()
	#var attack_instance = attack_animation.instantiate()
	#var death_instance = death_animation.instantiate()
	#
	#var idle_node = new_scene.get_node("idle")
	#var walk_node = new_scene.get_node("walk")
	#var attack_node = new_scene.get_node("attack")
	#var death_node = new_scene.get_node("death")
	#
	#var idle_frame0 = idle_instance.get_node("frame0")
	#var idle_player = idle_instance.get_node("AnimationPlayer")
	#var walk_frame0 = walk_instance.get_node("frame0")
	#var walk_player = walk_instance.get_node("AnimationPlayer")
	#var attack_frame0 = attack_instance.get_node("frame0")
	#var attack_player = attack_instance.get_node("AnimationPlayer")
	#var death_frame0 = death_instance.get_node("frame0")
	#var death_player = death_instance.get_node("AnimationPlayer")
	#idle_frame0.reparent(idle_node)
	#idle_frame0.rotation.x = deg_to_rad(90)
	#idle_player.reparent(idle_node)
	#
	#walk_frame0.reparent(walk_node)
	#walk_frame0.rotation.x = deg_to_rad(90)
	#walk_player.reparent(walk_node)
	#walk_frame0.hide()
	#
	#attack_frame0.reparent(attack_node)
	#attack_frame0.rotation.x = deg_to_rad(90)
	#attack_player.reparent(attack_node)
	#attack_frame0.hide()
	#
	#death_frame0.reparent(death_node)
	#death_frame0.rotation.x = deg_to_rad(90)
	#death_player.reparent(death_node)
	#death_frame0.hide()
#
	#idle_frame0.set_owner(new_scene)
	#idle_player.set_owner(new_scene)
	#walk_frame0.set_owner(new_scene)
	#walk_player.set_owner(new_scene)
	#attack_frame0.set_owner(new_scene)
	#attack_player.set_owner(new_scene)
	#death_frame0.set_owner(new_scene)
	#death_player.set_owner(new_scene)
#
	#return new_scene

#func place_characters():
	#var generic_characters_path = "res://game/actors/characters/generic_characters/"
	#var unfinished_characters_path = "res://game/actors/characters/unfinished_characters/"
	#var current_scene = get_scene()
	#var actors = current_scene.get_node("actors")
	#var placeholders = actors.get_node("placeholders")
	#var generic_characters = list_subdirectories(generic_characters_path)
	#var unfinished_characters = list_subdirectories(unfinished_characters_path)
	#for child in placeholders.get_children():
		#var character_name = scriptmap[child.scriptname]
		##print(child.scriptname, ": ", scriptmap[child.scriptname])
		#var scene_path
		#if character_name in generic_characters:
			#scene_path = generic_characters_path+character_name+"/"+character_name+".tscn"
		#elif character_name in unfinished_characters:
			#scene_path = unfinished_characters_path+character_name+"/"+character_name+".tscn"
		#else:
			#continue
		##print(scene_path)
		#var character_scene = load(scene_path)
		#var character_instance = character_scene.instantiate()
		#child.add_child(character_instance)
		#character_instance.set_owner(get_scene())
#endregion
