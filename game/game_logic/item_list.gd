extends Node

# TODO: should rings be just an armor type or it's own category?

var all_item_list = {}
var weapons = {}
var armor = {}
var spells = {}
var consumables = {}
var misc = {}

enum types {Axe, Blunt, Club, Damage, LightBow, \
 Longblade, MediumBow, Shortblade, Thrown, Chest, Head, Arm, \
 Leg, Hand, Boots, Shield, Self, Target, Area, Ring, \
 Book, Startooth, Shadowkey, Skeletonkey, Questitem}
enum armor_categories {Light, Medium, Heavy}

enum icon {Dagger, Sword, Club, Bludgeon, Axe, Bow, Food, Herb, Potion}

func _ready():
	add_all_weapons()
	add_all_armor()
	add_all_spells()
	add_all_consumables()
	add_all_other_items()

class Item:
	var name

class Weapon extends Item:
	var type
	var min_damage
	var max_damage
	var buy_price
	var sell_price
	var enchant

	func _init(arg0, arg1, arg2, arg3, arg4, arg5, arg6=null):
		name = arg0
		type = arg1
		min_damage = arg2
		max_damage = arg3
		buy_price = arg4
		sell_price = arg5
		enchant = arg6

class Spell extends Item:
	var type
	
	func _init(arg0, arg1):
		name = arg0
		type = arg1

class Armor extends Item:
	var type
	var slot
	var armor_value
	var buy_price
	var sell_price
	var enchant
	func _init(arg0, arg1, arg2, arg3, arg4, arg5, arg6=null):
		name = arg0
		type = arg1
		slot = arg2
		armor_value = arg3
		buy_price = arg4
		sell_price = arg5
		enchant = arg6

class Consumable extends Item:
	var buy_price
	var sell_price
	func _init(arg0, arg1, arg2):
		name = arg0
		buy_price = arg1
		sell_price = arg2
		
class Misc extends Item:
	var type
	func _init(arg0, arg1):
		name = arg0
		type = arg1

func add_weapon(id, item_name, type, min, max, buy, sell, enchant=null):
	var new_weapon = Weapon.new(item_name, type, min, max, buy, sell, enchant)
	weapons[id] = new_weapon
	all_item_list[id] = new_weapon

func add_armor(id, item_name, type, value, slot, buy, sell, enchant=null):
	var new_armor = Armor.new(item_name, type, value, slot, buy, sell, enchant)
	armor[id] = new_armor
	all_item_list[id] = new_armor

func add_spell(id, item_name, type):
	var new_spell = Spell.new(item_name, type)
	spells[id] = new_spell
	all_item_list[id] = new_spell

func add_consumable(id, item_name, buy=0, sell=0):
	var new_consumable = Consumable.new(item_name, buy, sell)
	consumables[id] = new_consumable
	all_item_list[id] = new_consumable

func add_misc(id, item_name, type):
	var new_misc = Misc.new(name, type)
	misc[id] = new_misc
	all_item_list[id] = new_misc

func get_item(item_name):
	return all_item_list[item_name]

func add_all_weapons():
	add_weapon(&"irondagger", "Iron Dagger", types.Shortblade , 4, 5, 38, 13)
	add_weapon(&"silverdagger", "Silver Dagger", types.Shortblade , 4, 6, 55, 19)
	add_weapon(&"steeldagger", "Steel Dagger", types.Shortblade , 4, 7, 78, 27)
	add_weapon(&"daedricdagger", "Daedric Dagger", types.Shortblade , 8, 2, 676, 237)
	add_weapon(&"duskdagger", "Dusk Dagger", types.Shortblade , 5, 7, 953, 334)
	add_weapon(&"deathdagger", "Death Dagger", types.Shortblade , 4, 0, 1304, 456)
	add_weapon(&"penumbricdagger", "Penumbric Dagger", types.Shortblade , 10, 25, 5075, 1776)
	add_weapon(&"ironshortsword", "Iron Shortsword", types.Shortblade , 4, 9, 143, 50)
	add_weapon(&"silvershortsword", "Silver Shortsword", types.Shortblade , 5, 0, 240, 84)
	add_weapon(&"steelshortsword", "Steel Shortsword", types.Shortblade , 5, 2, 377, 132)
	add_weapon(&"dwarvenshortsword", "Dwarven Shortsword", types.Shortblade , 7, 4, 806, 282)
	add_weapon(&"ebonyshortsword", "Ebony Shortsword", types.Shortblade , 10, 22, 3675, 1286)
	add_weapon(&"shadowwhisper", "Shadow Whisper", types.Shortblade , 4, 2, 1304, 456)
	add_weapon(&"ironlongsword", "Iron Longsword", types.Longblade , 4, 5, 712, 249)
	add_weapon(&"steellongsword", "Steel Longsword", types.Longblade , 5, 9, 1304, 456)
	add_weapon(&"silverlongsword", "Silver Longsword", types.Longblade , 4, 1, 1511, 529)
	add_weapon(&"mahklongsword", "Mahk Longsword", types.Longblade , 3, 6, 2578, 902)
	add_weapon(&"ebonylongsword", "Ebony Longsword", types.Longblade , 4, 7, 8970, 3140)
	add_weapon(&"daedriclongsword", "Daedric Longsword", types.Longblade , 4, 4, 15822, 5538)
	add_weapon(&"shadowstabber", "Shadow Stabber", types.Longblade , 10, 28, 6823, 2388)
	add_weapon(&"shadowblade", "Shadowblade", types.Longblade , 3, 0, 22605, 7912)
	add_weapon(&"ironbroadsword", "Iron Broadsword", types.Longblade , 4, 2, 303, 106)
	add_weapon(&"steelbroadsword", "Steel Broadsword", types.Longblade , 4, 4, 463, 162)
	add_weapon(&"ebonybroadsword", "Ebony Broadsword", types.Longblade , 6, 6, 4572, 1600)
	add_weapon(&"ironclaymore", "Iron Claymore", types.Longblade , 1, 4, 1511, 529)
	add_weapon(&"silverclaymore", "Silver Claymore", types.Longblade , 1, 7, 2272, 795)
	add_weapon(&"daedricclaymore", "Daedric Claymore", types.Longblade , 1, 0, 37497, 13124)
	add_weapon(&"club", "Club", types.Club , 3, 4, 15, 5)
	add_weapon(&"ironclub", "Iron Club", types.Blunt , 4, 5, 38, 13)
	add_weapon(&"steelclub", "Steel Club", types.Blunt , 5, 6, 78, 27)
	add_weapon(&"steelflail", "Steel Flail", types.Blunt , 3, 4, 377, 132)
	add_weapon(&"ebonywarmace", "Ebony Warmace", types.Blunt , 7, 6, 4106, 1437)
	add_weapon(&"daedricwarmace", "Daedric Warmace", types.Blunt , 3, 0, 4106, 1437)
	add_weapon(&"penumbricmace", "Penumbric Mace", types.Blunt , 2, 3, 5075, 1776)
	add_weapon(&"bludgeon", "Bludgeon", types.Blunt , 1, 9, 55, 19)
	add_weapon(&"spirethiefbludgeon", "Spire Thief Bludgeon", types.Blunt , 3, 3, 5617, 1966)
	add_weapon(&"steelmace", "Steel Mace", types.Blunt , 3, 7, 55, 19)
	add_weapon(&"silvermace", "Silver Mace", types.Blunt , 4, 8, 107, 37)
	add_weapon(&"ebonymace", "Ebony Mace", types.Blunt , 3, 6, 562, 197)
	add_weapon(&"daedricmace", "Daedric Mace", types.Blunt , 6, 6, 953, 334)
	add_weapon(&"azrasmace", "Azra's Mace", types.Blunt , 4, 2, 13575, 4751)
	add_weapon(&"steelaxe", "Steel Axe", types.Axe , 4, 4, 463, 162)
	add_weapon(&"ragadacleaver", "Ra' Gada Cleaver", types.Axe , 2, 6, 463, 162)
	add_weapon(&"shadecleaver", "Shade Cleaver", types.Axe , 10, 50, 35331, 12366)
	add_weapon(&"steelwaraxe", "Steel War Axe", types.Axe , 1, 0, 806, 282)
	add_weapon(&"dwarvenwaraxe", "Dwarven War Axe", types.Axe , 1, 4, 1511, 529)
	add_weapon(&"ebonywaraxe", "Ebony War Axe", types.Axe , 1, 7, 6823, 2388)
	add_weapon(&"daedricwaraxe", "Daedric War Axe", types.Axe , 2, 4, 13575, 4751)
	add_weapon(&"shadewaraxe", "Shade War Axe", types.Axe , 6, 0, 108779, 34255)
	add_weapon(&"ragadabattleaxe", "Ra' Gada Battle Axe", types.Axe , 6, 5, 3278, 1147)
	add_weapon(&"ironbattleaxe", "Iron Battle Axe", types.Axe , 2, 2, 4572, 1600)
	add_weapon(&"dwarvenbattleaxe", "Dwarven Battle Axe", types.Axe , 2, 5, 6199, 2170)
	add_weapon(&"doublebattleaxe", "Double Battle Axe", types.Axe , 6, 0, 13575, 4751)
	add_weapon(&"daedricbattleaxe", "Daedric Battle Axe", types.Axe , 2, 5, 58869, 21539)
	add_weapon(&"ironmace", "Iron Mace", types.Axe , 1, 8, 2578, 902)
	add_weapon(&"steelflail2", "Steel Flail", types.Axe , 1, 2, 4106, 1437)
	add_weapon(&"ragadawarmace", "Ra' Gada Warmace", types.Axe , 8, 2, 8207, 3096)
	add_weapon(&"ironthrowingknife", "Iron Throwing Knife", types.Thrown , 2, 3, 9, 3)
	add_weapon(&"steelthrowingknife", "Steel Throwing Knife", types.Thrown , 2, 4, 17, 6)
	add_weapon(&"glassthrowingknife", "Glass Throwing Knife", types.Thrown , 1, 6, 30, 11)
	add_weapon(&"penumbricthrowingknife", "Penumbric Throwing Knife", types.Thrown , 4, 6, 1353, 474)
	add_weapon(&"steelthrowingknife2", "Steel Throwing Knife", types.Thrown , 2, 5, 30, 11)
	add_weapon(&"silverthrowingknife", "Silver Throwing Knife", types.Thrown , 4, 5, 76, 27)
	add_weapon(&"ebonythrowingknife", "Ebony Throwing Knife", types.Thrown , 2, 0, 215, 75)
	add_weapon(&"daedricthrowingknife", "Daedric Throwing Knife", types.Thrown , 2, 2, 374, 131)
	add_weapon(&"shadowthrowingknife", "Shadow Throwing Knife", types.Thrown , 2, 7, 1125, 394)
	add_weapon(&"banditlongbow", "Bandit Longbow", types.LightBow , 3, 9, 215, 75)
	add_weapon(&"banditdouble-bow", "Bandit Double-bow", types.MediumBow , 4, 0, 2609, 913)
	add_weapon(&"ragadalongbow", "Ra' Gada Longbow", types.MediumBow , 5, 0, 10150, 3553)
	add_weapon(&"spirethieflongbow", "Spire Thief Longbow", types.MediumBow , 6, 6, 19567, 6848)
	add_weapon(&"daedriclongbow", "Daedric Longbow", types.MediumBow , 2, 0, 42214, 14775)
	add_weapon(&"steelcrossbow", "Steel Crossbow", types.MediumBow , 16, 24, 16415, 5745)
	add_weapon(&"dwarvencrossbow", "Dwarven Crossbow", types.MediumBow , 26, 34, 70662, 24732)

func add_all_armor():
	add_armor(&"reinforcedlinen", "Reinforced Linen", armor_categories.Light, types.Chest,1,10,2)
	add_armor(&"leathershirt", "Leather Shirt", armor_categories.Light, types.Chest,2,2,1)
	add_armor(&"boneshirt", "Bone Shirt", armor_categories.Light, types.Chest,4,11,4)
	add_armor(&"ebonyleather", "Ebony Leather", armor_categories.Light, types.Chest,11,302,106)
	add_armor(&"nightleather", "Nightleather", armor_categories.Light, types.Chest,13,117,41)
	add_armor(&"imperialnewtscalecuirass", "Imperial Newtscale Cuirass", armor_categories.Light, types.Chest,22,336,118)
	add_armor(&"shadowweave", "Shadowweave", armor_categories.Light, types.Chest,35,850,298)
	add_armor(&"cuirbollicuirass", "Cuirbolli Cuirass", armor_categories.Medium, types.Chest,2,2,1)
	add_armor(&"nordictrollbonecuirass", "Nordic Trollbone Cuirass", armor_categories.Medium, types.Chest,15,156,55)
	add_armor(&"ringmail", "Ringmail", armor_categories.Medium, types.Chest,15,156,55)
	add_armor(&"imperialsilvercuirass", "Imperial Silver Cuirass", armor_categories.Medium, types.Chest,25,434,152)
	add_armor(&"dragonstarscale", "Dragonstar Scale", armor_categories.Medium, types.Chest,32,711,249)
	add_armor(&"ebonycuirass", "Ebony Cuirass", armor_categories.Medium, types.Chest,35,850,298)
	add_armor(&"shadowring", "Shadowring", armor_categories.Medium, types.Chest,45,1406,492)
	add_armor(&"ironcuirass", "Iron Cuirass", armor_categories.Heavy, types.Chest,12,100,35)
	add_armor(&"nordicironcuirass", "Nordic Iron Cuirass", armor_categories.Heavy, types.Chest,14,136,48)
	add_armor(&"steelcuirass", "Steel Cuirass", armor_categories.Heavy, types.Chest,25,434,152)
	add_armor(&"daedriccuirass", "Daedric Cuirass", armor_categories.Heavy, types.Chest,45,1406,492)
	add_armor(&"shadowplate", "Shadowplate", armor_categories.Heavy, types.Chest,60,2500,875)
	add_armor(&"leathercap", "Leather Cap", armor_categories.Light, types.Head ,2,12,4)
	add_armor(&"nordicfurcap", "Nordic fur Cap", armor_categories.Light, types.Head ,3,28,10)
	add_armor(&"ragadalighthelm", "Ra' Gada Light Helm", armor_categories.Light, types.Head ,6,112,39)
	add_armor(&"starcoif", "Star Coif", armor_categories.Light, types.Head ,90,25312,8859)
	add_armor(&"chaincoif", "Chain Coif", armor_categories.Medium, types.Head ,18,1012,354)
	add_armor(&"steelhelm", "Steel Helm", armor_categories.Medium, types.Head ,20,1250,438)
	add_armor(&"dragonscalecoif", "Dragonscale Coif", armor_categories.Medium, types.Head ,21,1378,482)
	add_armor(&"dragonstarwatchhelm", "Dragonstar Watch Helm", armor_categories.Medium, types.Head ,22,1512,529)
	add_armor(&"ebonyclosedhelm", "Ebony Closed Helm", armor_categories.Medium, types.Head ,35,3828,1340)
	add_armor(&"glacialhelm", "Glacial Helm", armor_categories.Medium, types.Head ,41,5253,1839)
	add_armor(&"ironhelmet", "Iron Helmet", armor_categories.Heavy, types.Head ,19,1128,395)
	add_armor(&"dwemerhelm", "Dwemer Helm", armor_categories.Heavy, types.Head ,25,1953,684)
	add_armor(&"clothbracer", "Cloth Bracer", armor_categories.Light, types.Arm,1,2,1)
	add_armor(&"leatherbracer", "Leather Bracer", armor_categories.Light, types.Arm,2,11,4)
	add_armor(&"silverbracer", "Silver Bracer", armor_categories.Light, types.Arm,25,1736,608)
	add_armor(&"shadowband", "Shadow Band", armor_categories.Light, types.Arm,40,4444,1555)
	add_armor(&"orcishbracer", "Orcish Bracer", armor_categories.Medium, types.Arm,8,177,62)
	add_armor(&"orcishpauldron", "Orcish Pauldron", armor_categories.Medium, types.Arm,16,711,249)
	add_armor(&"ebonybracer", "Ebony Bracer", armor_categories.Medium, types.Arm,35,3402,1191)
	add_armor(&"ironbracer", "Iron Bracer", armor_categories.Heavy, types.Arm,12,400,140)
	add_armor(&"steelpauldron", "Steel Pauldron", armor_categories.Heavy, types.Arm,20,1111,389)
	add_armor(&"daedricpauldron", "Daedric Pauldron", armor_categories.Heavy, types.Arm,45,5625,1969)
	add_armor(&"leathergreaves", "Leather Greaves", armor_categories.Light, types.Leg,2,17,6)
	add_armor(&"nordicfurgreaves", "Nordic Fur Greaves", armor_categories.Light, types.Leg,3,40,14)
	add_armor(&"penumbricgreaves", "Penumbric Greaves", armor_categories.Light, types.Leg,60,16000,5600)
	add_armor(&"bonemoldgreaves", "Bonemold Greaves", armor_categories.Medium, types.Leg,6,160,56)
	add_armor(&"chaingreaves", "Chain Greaves", armor_categories.Medium, types.Leg,18,1440,504)
	add_armor(&"starteethgreaves", "Star Teeth Greaves", armor_categories.Medium, types.Leg,38,6417,2246)
	add_armor(&"irongreaves", "Iron Greaves", armor_categories.Heavy, types.Leg,19,1604,561)
	add_armor(&"steelgreaves", "Steel Greaves", armor_categories.Heavy, types.Leg,20,1777,622)
	add_armor(&"leathergloves", "Leather Gloves", armor_categories.Light, types.Hand,2,15,5)
	add_armor(&"trollbonegloves", "Trollbone Gloves", armor_categories.Light, types.Hand,4,62,22)
	add_armor(&"twilightgloves", "Twilight Gloves", armor_categories.Light, types.Hand,13,657,230)
	add_armor(&"shadowgloves", "Shadow Gloves", armor_categories.Light, types.Hand,40,6222,2178)
	add_armor(&"penumbricgauntlet", "Penumbric Gauntlet", armor_categories.Light, types.Hand,60,14000,4900)
	add_armor(&"studdedleathergloves", "Studded Leather Gloves", armor_categories.Medium, types.Hand,4,62,22)
	add_armor(&"irongauntlet", "Iron Gauntlet", armor_categories.Heavy, types.Hand,18,1260,441)
	add_armor(&"steelgauntlet", "Steel Gauntlet", armor_categories.Heavy, types.Hand,20,1555,544)
	add_armor(&"daedricgauntlet", "Daedric Gauntlet", armor_categories.Heavy, types.Hand,45,7875,2756)
	add_armor(&"softleatherboots", "Soft Leather Boots", armor_categories.Light, types.Boots,3,22,8)
	add_armor(&"leatherboots", "Leather Boots", armor_categories.Light, types.Boots,6,90,32)
	add_armor(&"nordicfurboots", "Nordic fur Boots", armor_categories.Light, types.Boots,9,202,71)
	add_armor(&"ebonyleatherboots", "Ebony Leather Boots", armor_categories.Light, types.Boots,11,302,106)
	add_armor(&"spirethiefboots", "Spire Thief Boots ", armor_categories.Light, types.Boots,18,810,284)
	add_armor(&"ragadashadeboots", "Ra' Gada Shade Boots", armor_categories.Light, types.Boots,60,9000,3150)
	add_armor(&"glassboots", "Glass Boots", armor_categories.Medium, types.Boots,12,360,126)
	add_armor(&"bonemoldboots", "Bonemold Boots", armor_categories.Medium, types.Boots,15,562,197)
	add_armor(&"dwarvenboots", "Dwarven Boots", armor_categories.Medium, types.Boots,20,1000,350)
	add_armor(&"ironboots", "Iron Boots", armor_categories.Heavy, types.Boots,19,902,316)
	add_armor(&"steelboots", "Steel Boots", armor_categories.Heavy, types.Boots,20,1000,350)
	add_armor(&"daedricboots", "Daedric Boots", armor_categories.Heavy, types.Boots,45,5062,1772)
	add_armor(&"leatherbuckler", "Leather Buckler", armor_categories.Light, types.Shield,4,25,9)
	add_armor(&"nordicleathershield", "Nordic Leather Shield", armor_categories.Light, types.Shield,8,100,35)
	add_armor(&"woodenbuckler", "Wooden Buckler", armor_categories.Light, types.Shield,9,126,44)
	add_armor(&"orcishheroshield", "Orcish Hero Shield", armor_categories.Light, types.Shield,10,156,55)
	add_armor(&"ragadaguardshield", "Ra' Gada Guard Shield", armor_categories.Light, types.Shield,12,225,79)
	add_armor(&"trollbonebuckler", "Trollbone Buckler", armor_categories.Light, types.Shield,16,400,140)
	add_armor(&"umbricshield", "Umbric Shield", armor_categories.Light, types.Shield,30,1406,492)
	add_armor(&"ironshield", "Iron Shield", armor_categories.Medium, types.Shield,19,564,197)
	add_armor(&"silvershield", "Silver Shield", armor_categories.Medium, types.Shield,25,976,342)
	add_armor(&"geldwyrshield", "Geldwyr Shield", armor_categories.Medium, types.Shield,28,1225,429)
	add_armor(&"steelshield", "Steel Shield", armor_categories.Medium, types.Shield,32,1600,560)
	add_armor(&"ebonyshield", "Ebony Shield", armor_categories.Medium, types.Shield,35,1914,670)
	add_armor(&"dragonstarshield", "Dragonstar Shield", armor_categories.Medium, types.Shield,40,2500,875)
	add_armor(&"daedricshield", "Daedric Shield", armor_categories.Heavy, types.Shield,45,3164,1107)
	add_armor(&"grimliswarhelm", "Grimli's War Helm", armor_categories.Medium, types.Head ,80,20000,1000)
	add_armor(&"morticusgreaves", "Morticus' Greaves", armor_categories.Light, types.Leg,55,20000,1000)
	add_armor(&"vajurasshield", "Vajuras' Shield", armor_categories.Medium, types.Shield,60,20000,1000)
	add_armor(&"banditgloves", "Bandit Gloves", armor_categories.Light, types.Arm,4,62,22)
	add_armor(&"shamanheaddress", "Shaman Headdress", armor_categories.Light, types.Head ,6,0,0)
	add_armor(&"silvergauntletsofcasting", "Silver Gauntlets of Casting", armor_categories.Light, types.Arm,16,6200,2170)

func add_all_spells():
	add_spell(&"absorb", "Absorb", types.Target)
	add_spell(&"azrassustenance", "Azra's Sustenance", types.Self)
	add_spell(&"azraswrath", "Azra's Wrath", types.Area)
	add_spell(&"blaze", "Blaze", types.Target)
	add_spell(&"blind", "Blind", types.Target)
	add_spell(&"bodytomind", "Body To Mind", types.Self)
	add_spell(&"curedisease", "Cure Disease", types.Self)
	add_spell(&"curepoison", "Cure Poison", types.Self)
	add_spell(&"daedricweapon", "Daedric Weapon", types.Self)
	add_spell(&"deadtodust", "Dead To Dust", types.Target)
	add_spell(&"deathhowl", "Death Howl", types.Target)
	add_spell(&"disease", "Disease", types.Target)
	add_spell(&"doomhammer", "Doom Hammer", types.Target)
	add_spell(&"drain", "Drain", types.Target)
	add_spell(&"energize", "Energize", types.Self)
	add_spell(&"fear", "Fear", types.Target)
	add_spell(&"feebleblade", "Feeble Blade", types.Target)
	add_spell(&"frenzy", "Frenzy", types.Self)
	add_spell(&"harmarmor", "Harm Armor", types.Target)
	add_spell(&"healwound", "Heal Wound", types.Self)
	add_spell(&"ignitefoe", "Ignite Foe", types.Target)
	add_spell(&"paralyze", "Paralyze", types.Target)
	add_spell(&"poison", "Poison", types.Target)
	add_spell(&"raisestrength", "Raise Strength", types.Self)
	add_spell(&"removeenchantment", "Remove Enchantment", types.Self)
	add_spell(&"righteousness", "Righteousness", types.Self)
	add_spell(&"sanctuary", "Sanctuary", types.Self)
	add_spell(&"shield", "Shield", types.Self)
	add_spell(&"weakness", "Weakness", types.Target)

func add_all_consumables():
	#add_consumable(&"healingpotion", "Healing Potion")
	add_consumable(&"ahmgalath", "Ahm Galath", 1325, 464)
	add_consumable(&"azraroot", "Azra Root", 3200, 1120)
	add_consumable(&"bervezjuice", "Bervez Juice", 12, 4)
	add_consumable(&"bittertea", "Bitter Tea", 0, 0)
	add_consumable(&"blackmushroom", "Black Mushroom", 550, 193)
	add_consumable(&"bounderskin", "Bounder Skin", 650, 228)
	add_consumable(&"bread", "Bread", 4, 1)
	add_consumable(&"clawrunnerskin", "Clawrunner Skin", 915, 320)
	add_consumable(&"cureblindnessbalm", "Cure Blindness Balm", 140, 49)
	add_consumable(&"deathsnowdust", "Deathsnow Dust", 320, 109)
	add_consumable(&"earthmoss", "Earth Moss", 1100, 385)
	add_consumable(&"floatersac", "Floater Sac", 400, 140)
	add_consumable(&"foxherb", "Fox Herb", 900, 315)
	add_consumable(&"ghostflame", "Ghost Flame", 85, 30)
	add_consumable(&"glacierflower", "Glacier Flower", 830, 291)
	add_consumable(&"glaciermoss", "Glacier Moss", 550, 193)
	add_consumable(&"goblinwax", "Goblin Wax", 1340, 469)
	add_consumable(&"graymushroom", "Gray Mushroom", 468, 164)
	add_consumable(&"healingpotion", "Healing Potion", 65, 23)
	add_consumable(&"horridtongue", "Horrid Tongue", 890, 314)
	add_consumable(&"icegrape", "Ice Grape", 535, 187)
	add_consumable(&"jadedust", "Jade Dust", 620, 217)
	add_consumable(&"lockdust", "Lock Dust", 175, 61)
	add_consumable(&"magickapotion", "Magicka Potion", 70, 25)
	add_consumable(&"manaice", "Mana Ice", 170, 60)
	add_consumable(&"mercredispotion", "Mercredi's Potion", 466, 163)
	add_consumable(&"mountainjerky", "Mountain Jerky", 220, 77)
	add_consumable(&"muffin", "Muffin", 2, 1)
	add_consumable(&"persaflower", "Persa Flower", 680, 238)
	add_consumable(&"ragadawarpaint", "Ra' Gada Warpaint", 190, 67)
	add_consumable(&"raiderchew", "Raider Chew", 2470, 865)
	add_consumable(&"ratseye", "Rat's Eye", 15, 5)
	add_consumable(&"redmushroom", "Red Mushroom", 448, 157)
	add_consumable(&"scythecrystals", "Scythe Crystals", 1200, 420)
	add_consumable(&"shadowbane", "Shadowbane", 1100, 385)
	add_consumable(&"shadowseed", "Shadowseed", 8000, 2800)
	add_consumable(&"skyrimpotion", "Skyrim Potion", 400, 140)
	add_consumable(&"smackwater", "Smack Water", 225, 79)
	add_consumable(&"smilepotion", "Smile Potion", 180, 63)
	add_consumable(&"snowraypowder", "Snowray Powder", 4700, 1645)
	add_consumable(&"spellwebthread", "Spell Web Thread", 3400, 1190)
	add_consumable(&"spiderheart", "Spider Heart", 40, 14)
	add_consumable(&"stew", "Stew", 25, 7)
	add_consumable(&"sunlightwater", "Sunlight Water", 380, 133)
	add_consumable(&"thunderherb", "Thunder Herb", 310, 109)
	add_consumable(&"toadmuffin", "Toad Muffin", 20, 7)
	add_consumable(&"topazdust", "Topaz Dust", 3200, 1120)
	add_consumable(&"trembleweed", "Tremble Weed", 188, 66)
	add_consumable(&"trothgarshealingpotion", "Trothgar's Healing Potion", 18, 6)
	add_consumable(&"trothgarsmagickapotion", "Trothgar's Magicka Potion", 20, 7)
	add_consumable(&"umbricfur", "Umbric Fur", 420, 147)
	add_consumable(&"verminbomb", "Vermin Bomb", 400, 140)
	add_consumable(&"vicarherb", "Vicar Herb", 45, 16)
	add_consumable(&"warriorbread", "Warrior Bread", 25, 9)
	add_consumable(&"warriorsstrength", "Warrior's Strength", 220, 77)
	add_consumable(&"wickederskin", "Wickeder Skin", 560, 196)
	add_consumable(&"zombiedust", "Zombie Dust", 170, 60)


func add_all_other_items():
	add_misc(&"startooth", "Star Tooth", types.Startooth)
	add_misc(&"delfransshadowkey", "Delfran's Shadowkey", types.Shadowkey)
	add_misc(&"spidersshadowkey", "Spider's Shadowkey", types.Shadowkey)
	add_misc(&"twilight shadowkey", "Twilight Shadowkey", types.Shadowkey)
	add_misc(&"goblinsshadowkey", "Goblin's Shadowkey", types.Shadowkey)
	add_misc(&"eglarsshadowkey", "Eglar's Shadowkey", types.Shadowkey)
	add_misc(&"tanyinsshadowkey", "Tanyin's Shadowkey", types.Shadowkey)
	add_misc(&"porlissshadowkey", "Porliss' Shadowkey", types.Shadowkey)
	add_misc(&"duvaisshadowkey", "Duvais' Shadowkey", types.Shadowkey)
	add_misc(&"lakvansshadowkey", "Lakvan's Shadowkey", types.Shadowkey)
	add_misc(&"perosiusshadowkey", "Perosius' Shadowkey", types.Shadowkey)
	add_misc(&"chieftainsshadowkey", "Chieftain's Shadowkey", types.Shadowkey)
	add_misc(&"skeletonkey", "Skeleton Key", types.Skeletonkey)
	add_misc(&"skyrimmap", "Skyrim Map", types.Questitem)
	add_misc(&"frozenkey", "Frozen Key", types.Questitem)
