extends Node

# TODO: should rings be just an armor type or it's own category?
# TODO: fix variable shadowing in classes

var all_item_list = {}
var weapons = {}
var armors = {}
var spells = {}
var consumables = {}
var misc = {}

enum ItemType {AXE,
				BLUNT,
				CLUB, 
				DAMAGE, 
				LIGHTBOW,
				LONGBLADE,
				MEDIUMBOW,
				SHORTBLADE,
				THROWN,
				CHEST,
				HEAD,
				ARM,
				LEG,
				HAND,
				BOOTS,
				SHIELD,
				SELF,
				TARGET,
				AREA,
				RING,
				BOOK,
				STARTOOTH,
				SHADOWKEY,
				SKELETONKEY,
				QUESTITEM
}

enum ArmorCategories {LIGHT, MEDIUM, HEAVY}

enum Icon {DAGGER, SWORD, CLUB, BLUDGEON, AXE, BOW, FOOD, HERB, POTION}

func _ready():
	add_all_weapons()
	add_all_armor()
	add_all_spells()
	add_all_consumables()
	add_all_other_items()

class Item extends Object:
	var id
	var name
	
	func _init(id, name):
		self.id = id
		self.name = name
	
	func duplicate():
		return Item.new(id, name)


class Weapon extends Item:
	var type
	var min_damage
	var max_damage
	var buy_price
	var sell_price
	var enchant

	func _init(id, name, type, min_damage, max_damage, buy_price, sell_price, enchant=null):
		super(id, name)
		self.type = type
		self.min_damage = min_damage
		self.max_damage = max_damage
		self.buy_price = buy_price
		self.sell_price = sell_price
		self.enchant = enchant

	# TODO: figure out this RefCounted stuff and why .get_class() doesn't work
	func get_class_name():
		return &"Weapon"
	
	func duplicate():
		return Weapon.new(id, name, type, min_damage, max_damage, buy_price, sell_price, enchant);


class Spell extends Item:
	var type
	var required_magic
	
	func _init(id, name, type, required_magic):
		super(id, name)
		self.type = type
		self.required_magic = required_magic
		
	func get_class_name():
		return &"Spell"
	
	func duplicate():
		return Spell.new(id, name, type, required_magic)


class Armor extends Item:
	var type
	var slot
	var armor_value
	var buy_price
	var sell_price
	var enchant
	func _init(id, name, type, slot, armor_value, buy_price, sell_price, enchant=null):
		super(id, name)
		self.type = type
		self.slot = slot
		self.armor_value = armor_value
		self.buy_price = buy_price
		self.sell_price = sell_price
		self.enchant = enchant
	
	func get_class_name():
		return &"Armor"
	
	func duplicate():
		return Armor.new(id, name, type, slot, armor_value, buy_price, sell_price, enchant)


class Consumable extends Item:
	var buy_price
	var sell_price
	func _init(id, name, buy_price, sell_price):
		super(id, name)
		self.buy_price = buy_price
		self.sell_price = sell_price

	func get_class_name():
		return &"Consumable"
	
	func duplicate():
		return Consumable.new(id, name, buy_price, sell_price)


class Misc extends Item:
	var item_type
	func _init(id, name, item_type):
		super(id, name)
		self.item_type = item_type

	func get_class_name():
		return &"Misc"
		
	func duplicate():
		return Misc.new(id, name, item_type)


class Gold extends Item:
	var amount
	func _init(arg0):
		#TODO: remember why we are even using IDs for
		id = &"goldpiece"
		name = &"Gold Piece"
		amount = arg0

	func get_class_name():
		return &"Gold"
	
	func duplicate():
		return Gold.new(amount)

func add_weapon(id, item_name, type, min_damage, max_damage, buy, sell, enchant=null):
	var new_weapon = Weapon.new(id, item_name, type, min_damage, max_damage, buy, sell, enchant)
	weapons[id] = new_weapon
	all_item_list[id] = new_weapon

func add_armor(id, item_name, type, value, slot, buy, sell, enchant=null):
	var new_armor = Armor.new(id, item_name, type, value, slot, buy, sell, enchant)
	armors[id] = new_armor
	all_item_list[id] = new_armor

func add_spell(id, item_name, type, required_magic=0):
	var new_spell = Spell.new(id, item_name, type, required_magic)
	spells[id] = new_spell
	all_item_list[id] = new_spell

func add_consumable(id, item_name, buy=0, sell=0):
	var new_consumable = Consumable.new(id, item_name, buy, sell)
	consumables[id] = new_consumable
	all_item_list[id] = new_consumable

func add_misc(id, item_name, type):
	var new_misc = Misc.new(id, name, type)
	misc[id] = new_misc
	all_item_list[id] = new_misc

func get_item(item_name, amount=1):
	if item_name == &"gold":
		var gold = Gold.new(amount)
		return gold
	return all_item_list[item_name]

func add_all_weapons():
	add_weapon(&"irondagger", "Iron Dagger", ItemType.SHORTBLADE , 4, 5, 38, 13)
	add_weapon(&"silverdagger", "Silver Dagger", ItemType.SHORTBLADE , 4, 6, 55, 19)
	add_weapon(&"steeldagger", "Steel Dagger", ItemType.SHORTBLADE , 4, 7, 78, 27)
	add_weapon(&"daedricdagger", "Daedric Dagger", ItemType.SHORTBLADE , 8, 2, 676, 237)
	add_weapon(&"duskdagger", "Dusk Dagger", ItemType.SHORTBLADE , 5, 7, 953, 334)
	add_weapon(&"deathdagger", "Death Dagger", ItemType.SHORTBLADE , 4, 0, 1304, 456)
	add_weapon(&"penumbricdagger", "Penumbric Dagger", ItemType.SHORTBLADE , 10, 25, 5075, 1776)
	add_weapon(&"ironshortsword", "Iron Shortsword", ItemType.SHORTBLADE , 4, 9, 143, 50)
	add_weapon(&"silvershortsword", "Silver Shortsword", ItemType.SHORTBLADE , 5, 0, 240, 84)
	add_weapon(&"steelshortsword", "Steel Shortsword", ItemType.SHORTBLADE , 5, 2, 377, 132)
	add_weapon(&"dwarvenshortsword", "Dwarven Shortsword", ItemType.SHORTBLADE , 7, 4, 806, 282)
	add_weapon(&"ebonyshortsword", "Ebony Shortsword", ItemType.SHORTBLADE , 10, 22, 3675, 1286)
	add_weapon(&"shadowwhisper", "Shadow Whisper", ItemType.SHORTBLADE , 4, 2, 1304, 456)
	add_weapon(&"ironlongsword", "Iron Longsword", ItemType.LONGBLADE , 4, 5, 712, 249)
	add_weapon(&"steellongsword", "Steel Longsword", ItemType.LONGBLADE , 5, 9, 1304, 456)
	add_weapon(&"silverlongsword", "Silver Longsword", ItemType.LONGBLADE , 4, 1, 1511, 529)
	add_weapon(&"mahklongsword", "Mahk Longsword", ItemType.LONGBLADE , 3, 6, 2578, 902)
	add_weapon(&"ebonylongsword", "Ebony Longsword", ItemType.LONGBLADE , 4, 7, 8970, 3140)
	add_weapon(&"daedriclongsword", "Daedric Longsword", ItemType.LONGBLADE , 4, 4, 15822, 5538)
	add_weapon(&"shadowstabber", "Shadow Stabber", ItemType.LONGBLADE , 10, 28, 6823, 2388)
	add_weapon(&"shadowblade", "Shadowblade", ItemType.LONGBLADE , 3, 0, 22605, 7912)
	add_weapon(&"ironbroadsword", "Iron Broadsword", ItemType.LONGBLADE , 4, 2, 303, 106)
	add_weapon(&"steelbroadsword", "Steel Broadsword", ItemType.LONGBLADE , 4, 4, 463, 162)
	add_weapon(&"ebonybroadsword", "Ebony Broadsword", ItemType.LONGBLADE , 6, 6, 4572, 1600)
	add_weapon(&"ironclaymore", "Iron Claymore", ItemType.LONGBLADE , 1, 4, 1511, 529)
	add_weapon(&"silverclaymore", "Silver Claymore", ItemType.LONGBLADE , 1, 7, 2272, 795)
	add_weapon(&"daedricclaymore", "Daedric Claymore", ItemType.LONGBLADE , 1, 0, 37497, 13124)
	add_weapon(&"club", "Club", ItemType.CLUB , 3, 4, 15, 5)
	add_weapon(&"ironclub", "Iron Club", ItemType.BLUNT , 4, 5, 38, 13)
	add_weapon(&"steelclub", "Steel Club", ItemType.BLUNT , 5, 6, 78, 27)
	add_weapon(&"steelflail", "Steel Flail", ItemType.BLUNT , 3, 4, 377, 132)
	add_weapon(&"ebonywarmace", "Ebony Warmace", ItemType.BLUNT , 7, 6, 4106, 1437)
	add_weapon(&"daedricwarmace", "Daedric Warmace", ItemType.BLUNT , 3, 0, 4106, 1437)
	add_weapon(&"penumbricmace", "Penumbric Mace", ItemType.BLUNT , 2, 3, 5075, 1776)
	add_weapon(&"bludgeon", "Bludgeon", ItemType.BLUNT , 1, 9, 55, 19)
	add_weapon(&"spirethiefbludgeon", "Spire Thief Bludgeon", ItemType.BLUNT , 3, 3, 5617, 1966)
	add_weapon(&"steelmace", "Steel Mace", ItemType.BLUNT , 3, 7, 55, 19)
	add_weapon(&"silvermace", "Silver Mace", ItemType.BLUNT , 4, 8, 107, 37)
	add_weapon(&"ebonymace", "Ebony Mace", ItemType.BLUNT , 3, 6, 562, 197)
	add_weapon(&"daedricmace", "Daedric Mace", ItemType.BLUNT , 6, 6, 953, 334)
	add_weapon(&"azrasmace", "Azra's Mace", ItemType.BLUNT , 4, 2, 13575, 4751)
	add_weapon(&"steelaxe", "Steel Axe", ItemType.AXE , 4, 4, 463, 162)
	add_weapon(&"ragadacleaver", "Ra' Gada Cleaver", ItemType.AXE , 2, 6, 463, 162)
	add_weapon(&"shadecleaver", "Shade Cleaver", ItemType.AXE , 10, 50, 35331, 12366)
	add_weapon(&"steelwaraxe", "Steel War Axe", ItemType.AXE , 1, 0, 806, 282)
	add_weapon(&"dwarvenwaraxe", "Dwarven War Axe", ItemType.AXE , 1, 4, 1511, 529)
	add_weapon(&"ebonywaraxe", "Ebony War Axe", ItemType.AXE , 1, 7, 6823, 2388)
	add_weapon(&"daedricwaraxe", "Daedric War Axe", ItemType.AXE , 2, 4, 13575, 4751)
	add_weapon(&"shadewaraxe", "Shade War Axe", ItemType.AXE , 6, 0, 108779, 34255)
	add_weapon(&"ragadabattleaxe", "Ra' Gada Battle Axe", ItemType.AXE , 6, 5, 3278, 1147)
	add_weapon(&"ironbattleaxe", "Iron Battle Axe", ItemType.AXE , 2, 2, 4572, 1600)
	add_weapon(&"dwarvenbattleaxe", "Dwarven Battle Axe", ItemType.AXE , 2, 5, 6199, 2170)
	add_weapon(&"doublebattleaxe", "Double Battle Axe", ItemType.AXE , 6, 0, 13575, 4751)
	add_weapon(&"daedricbattleaxe", "Daedric Battle Axe", ItemType.AXE , 2, 5, 58869, 21539)
	add_weapon(&"ironmace", "Iron Mace", ItemType.AXE , 1, 8, 2578, 902)
	add_weapon(&"steelflail2", "Steel Flail", ItemType.AXE , 1, 2, 4106, 1437)
	add_weapon(&"ragadawarmace", "Ra' Gada Warmace", ItemType.AXE , 8, 2, 8207, 3096)
	add_weapon(&"ironthrowingknife", "Iron Throwing Knife", ItemType.THROWN , 2, 3, 9, 3)
	add_weapon(&"steelthrowingknife", "Steel Throwing Knife", ItemType.THROWN , 2, 4, 17, 6)
	add_weapon(&"glassthrowingknife", "Glass Throwing Knife", ItemType.THROWN , 1, 6, 30, 11)
	add_weapon(&"penumbricthrowingknife", "Penumbric Throwing Knife", ItemType.THROWN , 4, 6, 1353, 474)
	add_weapon(&"steelthrowingknife2", "Steel Throwing Knife", ItemType.THROWN , 2, 5, 30, 11)
	add_weapon(&"silverthrowingknife", "Silver Throwing Knife", ItemType.THROWN , 4, 5, 76, 27)
	add_weapon(&"ebonythrowingknife", "Ebony Throwing Knife", ItemType.THROWN , 2, 0, 215, 75)
	add_weapon(&"daedricthrowingknife", "Daedric Throwing Knife", ItemType.THROWN , 2, 2, 374, 131)
	add_weapon(&"shadowthrowingknife", "Shadow Throwing Knife", ItemType.THROWN , 2, 7, 1125, 394)
	add_weapon(&"banditlongbow", "Bandit Longbow", ItemType.LIGHTBOW , 3, 9, 215, 75)
	add_weapon(&"banditdouble-bow", "Bandit Double-bow", ItemType.MEDIUMBOW , 4, 0, 2609, 913)
	add_weapon(&"ragadalongbow", "Ra' Gada Longbow", ItemType.MEDIUMBOW , 5, 0, 10150, 3553)
	add_weapon(&"spirethieflongbow", "Spire Thief Longbow", ItemType.MEDIUMBOW , 6, 6, 19567, 6848)
	add_weapon(&"daedriclongbow", "Daedric Longbow", ItemType.MEDIUMBOW , 2, 0, 42214, 14775)
	add_weapon(&"steelcrossbow", "Steel Crossbow", ItemType.MEDIUMBOW , 16, 24, 16415, 5745)
	add_weapon(&"dwarvencrossbow", "Dwarven Crossbow", ItemType.MEDIUMBOW , 26, 34, 70662, 24732)

func add_all_armor():
	add_armor(&"reinforcedlinen", "Reinforced Linen", ArmorCategories.LIGHT, ItemType.CHEST,1,10,2)
	add_armor(&"leathershirt", "Leather Shirt", ArmorCategories.LIGHT, ItemType.CHEST,2,2,1)
	add_armor(&"boneshirt", "Bone Shirt", ArmorCategories.LIGHT, ItemType.CHEST,4,11,4)
	add_armor(&"ebonyleather", "Ebony Leather", ArmorCategories.LIGHT, ItemType.CHEST,11,302,106)
	add_armor(&"nightleather", "Nightleather", ArmorCategories.LIGHT, ItemType.CHEST,13,117,41)
	add_armor(&"imperialnewtscalecuirass", "Imperial Newtscale Cuirass", ArmorCategories.LIGHT, ItemType.CHEST,22,336,118)
	add_armor(&"shadowweave", "Shadowweave", ArmorCategories.LIGHT, ItemType.CHEST,35,850,298)
	add_armor(&"cuirbollicuirass", "Cuirbolli Cuirass", ArmorCategories.MEDIUM, ItemType.CHEST,2,2,1)
	add_armor(&"nordictrollbonecuirass", "Nordic Trollbone Cuirass", ArmorCategories.MEDIUM, ItemType.CHEST,15,156,55)
	add_armor(&"ringmail", "Ringmail", ArmorCategories.MEDIUM, ItemType.CHEST,15,156,55)
	add_armor(&"imperialsilvercuirass", "Imperial Silver Cuirass", ArmorCategories.MEDIUM, ItemType.CHEST,25,434,152)
	add_armor(&"dragonstarscale", "Dragonstar Scale", ArmorCategories.MEDIUM, ItemType.CHEST,32,711,249)
	add_armor(&"ebonycuirass", "Ebony Cuirass", ArmorCategories.MEDIUM, ItemType.CHEST,35,850,298)
	add_armor(&"shadowring", "Shadowring", ArmorCategories.MEDIUM, ItemType.CHEST,45,1406,492)
	add_armor(&"ironcuirass", "Iron Cuirass", ArmorCategories.HEAVY, ItemType.CHEST,12,100,35)
	add_armor(&"nordicironcuirass", "Nordic Iron Cuirass", ArmorCategories.HEAVY, ItemType.CHEST,14,136,48)
	add_armor(&"steelcuirass", "Steel Cuirass", ArmorCategories.HEAVY, ItemType.CHEST,25,434,152)
	add_armor(&"daedriccuirass", "Daedric Cuirass", ArmorCategories.HEAVY, ItemType.CHEST,45,1406,492)
	add_armor(&"shadowplate", "Shadowplate", ArmorCategories.HEAVY, ItemType.CHEST,60,2500,875)
	add_armor(&"leathercap", "Leather Cap", ArmorCategories.LIGHT, ItemType.HEAD ,2,12,4)
	add_armor(&"nordicfurcap", "Nordic fur Cap", ArmorCategories.LIGHT, ItemType.HEAD ,3,28,10)
	add_armor(&"ragadalighthelm", "Ra' Gada Light Helm", ArmorCategories.LIGHT, ItemType.HEAD ,6,112,39)
	add_armor(&"starcoif", "Star Coif", ArmorCategories.LIGHT, ItemType.HEAD ,90,25312,8859)
	add_armor(&"chaincoif", "Chain Coif", ArmorCategories.MEDIUM, ItemType.HEAD ,18,1012,354)
	add_armor(&"steelhelm", "Steel Helm", ArmorCategories.MEDIUM, ItemType.HEAD ,20,1250,438)
	add_armor(&"dragonscalecoif", "Dragonscale Coif", ArmorCategories.MEDIUM, ItemType.HEAD ,21,1378,482)
	add_armor(&"dragonstarwatchhelm", "Dragonstar Watch Helm", ArmorCategories.MEDIUM, ItemType.HEAD ,22,1512,529)
	add_armor(&"ebonyclosedhelm", "Ebony Closed Helm", ArmorCategories.MEDIUM, ItemType.HEAD ,35,3828,1340)
	add_armor(&"glacialhelm", "Glacial Helm", ArmorCategories.MEDIUM, ItemType.HEAD ,41,5253,1839)
	add_armor(&"ironhelmet", "Iron Helmet", ArmorCategories.HEAVY, ItemType.HEAD ,19,1128,395)
	add_armor(&"dwemerhelm", "Dwemer Helm", ArmorCategories.HEAVY, ItemType.HEAD ,25,1953,684)
	add_armor(&"clothbracer", "Cloth Bracer", ArmorCategories.LIGHT, ItemType.ARM,1,2,1)
	add_armor(&"leatherbracer", "Leather Bracer", ArmorCategories.LIGHT, ItemType.ARM,2,11,4)
	add_armor(&"silverbracer", "Silver Bracer", ArmorCategories.LIGHT, ItemType.ARM,25,1736,608)
	add_armor(&"shadowband", "Shadow Band", ArmorCategories.LIGHT, ItemType.ARM,40,4444,1555)
	add_armor(&"orcishbracer", "Orcish Bracer", ArmorCategories.MEDIUM, ItemType.ARM,8,177,62)
	add_armor(&"orcishpauldron", "Orcish Pauldron", ArmorCategories.MEDIUM, ItemType.ARM,16,711,249)
	add_armor(&"ebonybracer", "Ebony Bracer", ArmorCategories.MEDIUM, ItemType.ARM,35,3402,1191)
	add_armor(&"ironbracer", "Iron Bracer", ArmorCategories.HEAVY, ItemType.ARM,12,400,140)
	add_armor(&"steelpauldron", "Steel Pauldron", ArmorCategories.HEAVY, ItemType.ARM,20,1111,389)
	add_armor(&"daedricpauldron", "Daedric Pauldron", ArmorCategories.HEAVY, ItemType.ARM,45,5625,1969)
	add_armor(&"leathergreaves", "Leather Greaves", ArmorCategories.LIGHT, ItemType.LEG,2,17,6)
	add_armor(&"nordicfurgreaves", "Nordic Fur Greaves", ArmorCategories.LIGHT, ItemType.LEG,3,40,14)
	add_armor(&"penumbricgreaves", "Penumbric Greaves", ArmorCategories.LIGHT, ItemType.LEG,60,16000,5600)
	add_armor(&"bonemoldgreaves", "Bonemold Greaves", ArmorCategories.MEDIUM, ItemType.LEG,6,160,56)
	add_armor(&"chaingreaves", "Chain Greaves", ArmorCategories.MEDIUM, ItemType.LEG,18,1440,504)
	add_armor(&"starteethgreaves", "Star Teeth Greaves", ArmorCategories.MEDIUM, ItemType.LEG,38,6417,2246)
	add_armor(&"irongreaves", "Iron Greaves", ArmorCategories.HEAVY, ItemType.LEG,19,1604,561)
	add_armor(&"steelgreaves", "Steel Greaves", ArmorCategories.HEAVY, ItemType.LEG,20,1777,622)
	add_armor(&"leathergloves", "Leather Gloves", ArmorCategories.LIGHT, ItemType.HAND,2,15,5)
	add_armor(&"trollbonegloves", "Trollbone Gloves", ArmorCategories.LIGHT, ItemType.HAND,4,62,22)
	add_armor(&"twilightgloves", "Twilight Gloves", ArmorCategories.LIGHT, ItemType.HAND,13,657,230)
	add_armor(&"shadowgloves", "Shadow Gloves", ArmorCategories.LIGHT, ItemType.HAND,40,6222,2178)
	add_armor(&"penumbricgauntlet", "Penumbric Gauntlet", ArmorCategories.LIGHT, ItemType.HAND,60,14000,4900)
	add_armor(&"studdedleathergloves", "Studded Leather Gloves", ArmorCategories.MEDIUM, ItemType.HAND,4,62,22)
	add_armor(&"irongauntlet", "Iron Gauntlet", ArmorCategories.HEAVY, ItemType.HAND,18,1260,441)
	add_armor(&"steelgauntlet", "Steel Gauntlet", ArmorCategories.HEAVY, ItemType.HAND,20,1555,544)
	add_armor(&"daedricgauntlet", "Daedric Gauntlet", ArmorCategories.HEAVY, ItemType.HAND,45,7875,2756)
	add_armor(&"softleatherboots", "Soft Leather Boots", ArmorCategories.LIGHT, ItemType.BOOTS,3,22,8)
	add_armor(&"leatherboots", "Leather Boots", ArmorCategories.LIGHT, ItemType.BOOTS,6,90,32)
	add_armor(&"nordicfurboots", "Nordic fur Boots", ArmorCategories.LIGHT, ItemType.BOOTS,9,202,71)
	add_armor(&"ebonyleatherboots", "Ebony Leather Boots", ArmorCategories.LIGHT, ItemType.BOOTS,11,302,106)
	add_armor(&"spirethiefboots", "Spire Thief Boots ", ArmorCategories.LIGHT, ItemType.BOOTS,18,810,284)
	add_armor(&"ragadashadeboots", "Ra' Gada Shade Boots", ArmorCategories.LIGHT, ItemType.BOOTS,60,9000,3150)
	add_armor(&"glassboots", "Glass Boots", ArmorCategories.MEDIUM, ItemType.BOOTS,12,360,126)
	add_armor(&"bonemoldboots", "Bonemold Boots", ArmorCategories.MEDIUM, ItemType.BOOTS,15,562,197)
	add_armor(&"dwarvenboots", "Dwarven Boots", ArmorCategories.MEDIUM, ItemType.BOOTS,20,1000,350)
	add_armor(&"ironboots", "Iron Boots", ArmorCategories.HEAVY, ItemType.BOOTS,19,902,316)
	add_armor(&"steelboots", "Steel Boots", ArmorCategories.HEAVY, ItemType.BOOTS,20,1000,350)
	add_armor(&"daedricboots", "Daedric Boots", ArmorCategories.HEAVY, ItemType.BOOTS,45,5062,1772)
	add_armor(&"leatherbuckler", "Leather Buckler", ArmorCategories.LIGHT, ItemType.SHIELD,4,25,9)
	add_armor(&"nordicleathershield", "Nordic Leather Shield", ArmorCategories.LIGHT, ItemType.SHIELD,8,100,35)
	add_armor(&"woodenbuckler", "Wooden Buckler", ArmorCategories.LIGHT, ItemType.SHIELD,9,126,44)
	add_armor(&"orcishheroshield", "Orcish Hero Shield", ArmorCategories.LIGHT, ItemType.SHIELD,10,156,55)
	add_armor(&"ragadaguardshield", "Ra' Gada Guard Shield", ArmorCategories.LIGHT, ItemType.SHIELD,12,225,79)
	add_armor(&"trollbonebuckler", "Trollbone Buckler", ArmorCategories.LIGHT, ItemType.SHIELD,16,400,140)
	add_armor(&"umbricshield", "Umbric Shield", ArmorCategories.LIGHT, ItemType.SHIELD,30,1406,492)
	add_armor(&"ironshield", "Iron Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,19,564,197)
	add_armor(&"silvershield", "Silver Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,25,976,342)
	add_armor(&"geldwyrshield", "Geldwyr Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,28,1225,429)
	add_armor(&"steelshield", "Steel Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,32,1600,560)
	add_armor(&"ebonyshield", "Ebony Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,35,1914,670)
	add_armor(&"dragonstarshield", "Dragonstar Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,40,2500,875)
	add_armor(&"daedricshield", "Daedric Shield", ArmorCategories.HEAVY, ItemType.SHIELD,45,3164,1107)
	add_armor(&"grimliswarhelm", "Grimli's War Helm", ArmorCategories.MEDIUM, ItemType.HEAD ,80,20000,1000)
	add_armor(&"morticusgreaves", "Morticus' Greaves", ArmorCategories.LIGHT, ItemType.LEG,55,20000,1000)
	add_armor(&"vajurasshield", "Vajuras' Shield", ArmorCategories.MEDIUM, ItemType.SHIELD,60,20000,1000)
	add_armor(&"banditgloves", "Bandit Gloves", ArmorCategories.LIGHT, ItemType.ARM,4,62,22)
	add_armor(&"shamanheaddress", "Shaman Headdress", ArmorCategories.LIGHT, ItemType.HEAD ,6,0,0)
	add_armor(&"silvergauntletsofcasting", "Silver Gauntlets of Casting", ArmorCategories.LIGHT, ItemType.ARM,16,6200,2170)

func add_all_spells():
	add_spell(&"absorb", "Absorb", ItemType.TARGET, 10)
	add_spell(&"azrassustenance", "Azra's Sustenance", ItemType.SELF, 10)
	add_spell(&"azraswrath", "Azra's Wrath", ItemType.AREA, 10)
	add_spell(&"blaze", "Blaze", ItemType.TARGET, 10)
	add_spell(&"blind", "Blind", ItemType.TARGET, 10)
	add_spell(&"bodytomind", "Body To Mind", ItemType.SELF, 10)
	add_spell(&"curedisease", "Cure Disease", ItemType.SELF, 10)
	add_spell(&"curepoison", "Cure Poison", ItemType.SELF, 10)
	add_spell(&"daedricweapon", "Daedric Weapon", ItemType.SELF, 10)
	add_spell(&"deadtodust", "Dead To Dust", ItemType.TARGET, 10)
	add_spell(&"deathhowl", "Death Howl", ItemType.TARGET, 10)
	add_spell(&"disease", "Disease", ItemType.TARGET, 10)
	add_spell(&"doomhammer", "Doom Hammer", ItemType.TARGET, 30)
	add_spell(&"drain", "Drain", ItemType.TARGET, 10)
	add_spell(&"energize", "Energize", ItemType.SELF, 10)
	add_spell(&"fear", "Fear", ItemType.TARGET, 10)
	add_spell(&"feebleblade", "Feeble Blade", ItemType.TARGET, 10)
	add_spell(&"frenzy", "Frenzy", ItemType.SELF, 10)
	add_spell(&"harmarmor", "Harm Armor", ItemType.TARGET, 10)
	add_spell(&"healwound", "Heal Wound", ItemType.SELF, 20)
	add_spell(&"ignitefoe", "Ignite Foe", ItemType.TARGET, 10)
	add_spell(&"paralyze", "Paralyze", ItemType.TARGET, 10)
	add_spell(&"poison", "Poison", ItemType.TARGET, 10)
	add_spell(&"raisestrength", "Raise Strength", ItemType.SELF, 10)
	add_spell(&"removeenchantment", "Remove Enchantment", ItemType.SELF, 10)
	add_spell(&"righteousness", "Righteousness", ItemType.SELF, 10)
	add_spell(&"sanctuary", "Sanctuary", ItemType.SELF, 10)
	add_spell(&"shield", "Shield", ItemType.SELF, 10)
	add_spell(&"weakness", "Weakness", ItemType.TARGET, 10)

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
	add_misc(&"startooth", "Star Tooth", ItemType.STARTOOTH)
	add_misc(&"delfransshadowkey", "Delfran's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"spidersshadowkey", "Spider's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"twilight shadowkey", "Twilight Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"goblinsshadowkey", "Goblin's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"eglarsshadowkey", "Eglar's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"tanyinsshadowkey", "Tanyin's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"porlissshadowkey", "Porliss' Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"duvaisshadowkey", "Duvais' Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"lakvansshadowkey", "Lakvan's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"perosiusshadowkey", "Perosius' Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"chieftainsshadowkey", "Chieftain's Shadowkey", ItemType.SHADOWKEY)
	add_misc(&"skeletonkey", "Skeleton Key", ItemType.SKELETONKEY)
	add_misc(&"skyrimmap", "Skyrim Map", ItemType.QUESTITEM)
	add_misc(&"frozenkey", "Frozen Key", ItemType.QUESTITEM)
