extends Node

# TODO: rename node to item_list
# TODO: should rings be just an armor type or it's own category?

#const weapons = []
var all_item_list = {}
var weapons_list = {}
var armors_list = {}
var spells_list = {}
var consumables_list = {}
var misc_list = {}

enum types {Axe, Blunt, Club, Damage, LightBow, \
 Longblade, MediumBow, Shortblade, Thrown, Self, Target, Area, Ring, Book}
enum armors_types {Helm, Chest, Arms, Legs, Hands, Boots, Shield}
enum armors_class {Light, Medium, Heavy}

class Item:
	var name
	var id

class Weapon extends Item:
	var type
	var min_damage
	var max_damage
	var buy_price
	var sell_price
	var enchant

	func _init(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7=null):
		id = arg0
		name = arg1
		type = arg2
		min_damage = arg3
		max_damage = arg4
		buy_price = arg5
		sell_price = arg6
		enchant = arg7

class Spell extends Item:
	var type
	
	func _init(arg0, arg1, arg2):
		id = arg0
		name = arg1
		type = arg2

class Armor extends Item:
	var type
	var armor_value
	var slot
	var buy_price
	var sell_price
	var enchant
	func _init(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7=null):
		id = arg0
		name = arg1
		type = arg2
		armor_value = arg3
		slot = arg4
		buy_price = arg5
		sell_price = arg6
		enchant = arg7

class Consumable extends Item:
	var buy_price
	var sell_price
	func _init(arg0, arg1, arg2, arg3):
		id = arg0
		name = arg1
		buy_price = arg2
		sell_price = arg3
		
class Misc extends Item:
	var type
	func _init(arg0, arg1, arg2):
		id = arg0
		name = arg1
		type = arg2

func get_item(id):
	if(weapons_list.has(id)):
		return weapons_list[id]
	elif(armors_list.has(id)):
		return armors_list[id]
	elif(consumables_list.has(id)):
		return consumables_list[id]
	elif(spells_list.has(id)):
		return spells_list[id]
	elif(misc_list.has(id)):
		return misc_list[id]
	else:
		return null
		
func _ready():
	# Add all weapons to item list & weapon list
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
	
	# Add all armors to item list & armors list
	
	# Add all consumables to item list & consumables list
	add_consumable(&"healingpotion", "Healing Potion")
	
	# Add all spells to item list & spells list
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
	add_spell(&"Sanctuary", "Sanctuary", types.Self)
	add_spell(&"shield", "Shield", types.Self)
	add_spell(&"weakness", "Weakness", types.Target)
	
	# Add all misc to item list & misc list

func add_weapon(id, name, type, min, max, buy, sell, enchant=null):
	var new_weapon = Weapon.new(id, name, type, min, max, buy, sell, enchant)
	weapons_list[id] = new_weapon
	all_item_list[id] = new_weapon


func add_armor(id, name, type, value, slot, buy, sell, enchant=null):
	var new_armor = Armor.new(id, name, type, value, slot, buy, sell, enchant)
	armors_list[id] = new_armor
	all_item_list[id] = new_armor

func add_spell(id, name, type):
	var new_spell = Spell.new(id, name, type)
	spells_list[id] = new_spell
	all_item_list[id] = new_spell

func add_consumable(id, name, buy=0, sell=0):
	var new_consumable = Consumable.new(id, name, buy, sell)
	consumables_list[id] = new_consumable
	all_item_list[id] = new_consumable

func add_misc(id, name, type):
	var new_misc = Misc.new(id, name, type)
	misc_list[id] = new_misc
	all_item_list[id] = new_misc
