extends Node

#const weapons = []

enum types {Axe, Blunt, Club, Damage, LightBow, \
 Longblade, MediumBow, Shortblade, Thrown, Self, Target, Area}

enum armors_types {Helm, Chest, Arms, Legs, Hands, Boots, Shield}
enum armors_class {Light, Medium, Heavy}

#var weapon_dict = { \
const weapons = { \
	&"irondagger" : [ "Iron Dagger", types.Shortblade , 4, 5, 38, 13], \
	&"silverdagger" : [ "Silver Dagger", types.Shortblade , 4, 6, 55, 19], \
	&"steeldagger" : [ "Steel Dagger", types.Shortblade , 4, 7, 78, 27], \
	&"daedricdagger" : [ "Daedric Dagger", types.Shortblade , 8, 2, 676, 237], \
	&"duskdagger" : [ "Dusk Dagger", types.Shortblade , 5, 7, 953, 334], \
	&"deathdagger" : [ "Death Dagger", types.Shortblade , 4, 0, 1304, 456], \
	&"penumbricdagger" : [ "Penumbric Dagger", types.Shortblade , 10, 25, 5075, 1776], \
	&"ironshortsword" : [ "Iron Shortsword", types.Shortblade , 4, 9, 143, 50], \
	&"silvershortsword" : [ "Silver Shortsword", types.Shortblade , 5, 0, 240, 84], \
	&"steelshortsword" : [ "Steel Shortsword", types.Shortblade , 5, 2, 377, 132], \
	&"dwarvenshortsword" : [ "Dwarven Shortsword", types.Shortblade , 7, 4, 806, 282], \
	&"ebonyshortsword" : [ "Ebony Shortsword", types.Shortblade , 10, 22, 3675, 1286], \
	&"shadowwhisper" : [ "Shadow Whisper", types.Shortblade , 4, 2, 1304, 456], \
	&"ironlongsword" : [ "Iron Longsword", types.Longblade , 4, 5, 712, 249], \
	&"steellongsword" : [ "Steel Longsword", types.Longblade , 5, 9, 1304, 456], \
	&"silverlongsword" : [ "Silver Longsword", types.Longblade , 4, 1, 1511, 529], \
	&"mahklongsword" : [ "Mahk Longsword", types.Longblade , 3, 6, 2578, 902], \
	&"ebonylongsword" : [ "Ebony Longsword", types.Longblade , 4, 7, 8970, 3140], \
	&"daedriclongsword" : [ "Daedric Longsword", types.Longblade , 4, 4, 15822, 5538], \
	&"shadowstabber" : [ "Shadow Stabber", types.Longblade , 10, 28, 6823, 2388], \
	&"shadowblade" : [ "Shadowblade", types.Longblade , 3, 0, 22605, 7912], \
	&"ironbroadsword" : [ "Iron Broadsword", types.Longblade , 4, 2, 303, 106], \
	&"steelbroadsword" : [ "Steel Broadsword", types.Longblade , 4, 4, 463, 162], \
	&"ebonybroadsword" : [ "Ebony Broadsword", types.Longblade , 6, 6, 4572, 1600], \
	&"ironclaymore" : [ "Iron Claymore", types.Longblade , 1, 4, 1511, 529], \
	&"silverclaymore" : [ "Silver Claymore", types.Longblade , 1, 7, 2272, 795], \
	&"daedricclaymore" : [ "Daedric Claymore", types.Longblade , 1, 0, 37497, 13124], \
	&"club" : [ "Club", types.Club , 3, 4, 15, 5], \
	&"ironclub" : [ "Iron Club", types.Blunt , 4, 5, 38, 13], \
	&"steelclub" : [ "Steel Club", types.Blunt , 5, 6, 78, 27], \
	&"steelflail" : [ "Steel Flail", types.Blunt , 3, 4, 377, 132], \
	&"ebonywarmace" : [ "Ebony Warmace", types.Blunt , 7, 6, 4106, 1437], \
	&"daedricwarmace" : [ "Daedric Warmace", types.Blunt , 3, 0, 4106, 1437], \
	&"penumbricmace" : [ "Penumbric Mace", types.Blunt , 2, 3, 5075, 1776], \
	&"bludgeon" : [ "Bludgeon", types.Blunt , 1, 9, 55, 19], \
	&"spirethiefbludgeon" : [ "Spire Thief Bludgeon", types.Blunt , 3, 3, 5617, 1966], \
	&"steelmace" : [ "Steel Mace", types.Blunt , 3, 7, 55, 19], \
	&"silvermace" : [ "Silver Mace", types.Blunt , 4, 8, 107, 37], \
	&"ebonymace" : [ "Ebony Mace", types.Blunt , 3, 6, 562, 197], \
	&"daedricmace" : [ "Daedric Mace", types.Blunt , 6, 6, 953, 334], \
	&"azrasmace" : [ "Azra's Mace", types.Blunt , 4, 2, 13575, 4751], \
	&"steelaxe" : [ "Steel Axe", types.Axe , 4, 4, 463, 162], \
	&"ragadacleaver" : [ "Ra' Gada Cleaver", types.Axe , 2, 6, 463, 162], \
	&"shadecleaver" : [ "Shade Cleaver", types.Axe , 10, 50, 35331, 12366], \
	&"steelwaraxe" : [ "Steel War Axe", types.Axe , 1, 0, 806, 282], \
	&"dwarvenwaraxe" : [ "Dwarven War Axe", types.Axe , 1, 4, 1511, 529], \
	&"ebonywaraxe" : [ "Ebony War Axe", types.Axe , 1, 7, 6823, 2388], \
	&"daedricwaraxe" : [ "Daedric War Axe", types.Axe , 2, 4, 13575, 4751], \
	&"shadewaraxe" : [ "Shade War Axe", types.Axe , 6, 0, 108779, 34255], \
	&"ragadabattleaxe" : [ "Ra' Gada Battle Axe", types.Axe , 6, 5, 3278, 1147], \
	&"ironbattleaxe" : [ "Iron Battle Axe", types.Axe , 2, 2, 4572, 1600], \
	&"dwarvenbattleaxe" : [ "Dwarven Battle Axe", types.Axe , 2, 5, 6199, 2170], \
	&"doublebattleaxe" : [ "Double Battle Axe", types.Axe , 6, 0, 13575, 4751], \
	&"daedricbattleaxe" : [ "Daedric Battle Axe", types.Axe , 2, 5, 58869, 21539], \
	&"ironmace" : [ "Iron Mace", types.Axe , 1, 8, 2578, 902], \
	#&"steelflail" : [ "Steel Flail", types.Axe , 1, 2, 4106, 1437], \
	&"ragadawarmace" : [ "Ra' Gada Warmace", types.Axe , 8, 2, 8207, 3096], \
	&"ironthrowingknife" : [ "Iron Throwing Knife", types.Thrown , 2, 3, 9, 3], \
	&"steelthrowingknife" : [ "Steel Throwing Knife", types.Thrown , 2, 4, 17, 6], \
	&"glassthrowingknife" : [ "Glass Throwing Knife", types.Thrown , 1, 6, 30, 11], \
	&"penumbricthrowingknife" : [ "Penumbric Throwing Knife", types.Thrown , 4, 6, 1353, 474], \
	#&"steelthrowingknife" : [ "Steel Throwing Knife", types.Thrown , 2, 5, 30, 11], \
	&"silverthrowingknife" : [ "Silver Throwing Knife", types.Thrown , 4, 5, 76, 27], \
	&"ebonythrowingknife" : [ "Ebony Throwing Knife", types.Thrown , 2, 0, 215, 75], \
	&"daedricthrowingknife" : [ "Daedric Throwing Knife", types.Thrown , 2, 2, 374, 131], \
	&"shadowthrowingknife" : [ "Shadow Throwing Knife", types.Thrown , 2, 7, 1125, 394], \
	&"banditlongbow" : [ "Bandit Longbow", types.LightBow , 3, 9, 215, 75], \
	&"banditdouble-bow" : [ "Bandit Double-bow", types.MediumBow , 4, 0, 2609, 913], \
	&"ragadalongbow" : [ "Ra' Gada Longbow", types.MediumBow , 5, 0, 10150, 3553], \
	&"spirethieflongbow" : [ "Spire Thief Longbow", types.MediumBow , 6, 6, 19567, 6848], \
	&"daedriclongbow" : [ "Daedric Longbow", types.MediumBow , 2, 0, 42214, 14775], \
	&"steelcrossbow" : [ "Steel Crossbow", types.MediumBow , 16, 24, 16415, 5745], \
	&"dwarvencrossbow" : [ "Dwarven Crossbow", types.MediumBow , 26, 34, 70662, 24732]
}

const armors = { }

const spells = { \
	&"absorb" : [ "Absorb", types.Target ],
	&"azrassustenance" : [ "Azra's Sustenance", types.Self ],
	&"azraswrath" : [ "Azra's Wrath", types.Area ],
	&"blaze" : [ "Blaze", types.Target ],
	&"blind" : [ "Blind", types.Target ],
	&"bodytomind" : [ "Body To Mind", types.Self ],
	&"curedisease" : [ "Cure Disease", types.Self ],
	&"curepoison" : [ "Cure Poison", types.Self ],
	&"daedricweapon" : [ "Daedric Weapon", types.Self ],
	&"deadtodust" : [ "Dead To Dust", types.Target ],
	&"deathhowl" : [ "Death Howl", types.Target ],
	&"disease" : [ "Disease", types.Target ],
	&"doomhammer" : [ "Doom Hammer", types.Target ],
	&"drain" : [ "Drain", types.Target ],
	&"energize" : [ "Energize", types.Self ],
	&"fear" : [ "Fear", types.Target ],
	&"feebleblade" : [ "Feeble Blade", types.Target ],
	&"frenzy" : [ "Frenzy", types.Self ],
	&"harmarmor" : [ "Harm Armor", types.Target ],
	&"healwound" : [ "Heal Wound", types.Self ],
	&"ignitefoe" : [ "Ignite Foe", types.Target ],
	&"paralyze" : [ "Paralyze", types.Target ],
	&"poison" : [ "Poison", types.Target ],
	&"raisestrength" : [ "Raise Strength", types.Self ],
	&"removeenchantment" : [ "Remove Enchantment", types.Self ],
	&"righteousness" : [ "Righteousness", types.Self ],
	&"sanctuary" : [ "Sanctuary", types.Self ],
	&"shield" : [ "Shield", types.Self ],
	&"weakness" : [ "Weakness", types.Target ]
}

const consumables = {
	&"healingpotion" : [ "Healing Potion" ]
}

const misc = {
	
}

func get_item(id):
	if(weapons.has(id)):
		return weapons[id]
	elif(armors.has(id)):
		return armors[id]
	elif(consumables.has(id)):
		return consumables[id]
	elif(spells.has(id)):
		return spells[id]
	elif(misc.has(id)):
		return misc[id]
	else:
		return null
