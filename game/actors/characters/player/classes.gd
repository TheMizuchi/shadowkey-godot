class_name ClassCharacter

enum Classes {ASSASSIN, BARBARIAN, BATTLEMAGE, KNIGHT, NIGHTBLADE, ROGUE, SORCERER, SPELLSWORD, THIEF}
enum Guilds {FIGHTER, MAGE, THIEVES}

const ItemListEnum = preload("res://game/game_logic/item_list.gd")

@export var charClass: Classes ## Which class the character has
@export var charGuild: Guilds ## Which type of class 
@export var armorType: Array[ItemListEnum.ArmorCategories] = [] ## Armors type allows for the class
@export var shieldType: Array[ItemListEnum.ArmorCategories] = [] ## Shield type allows for the class
@export var weaponType: Array[ItemListEnum.ItemType] = [] ## Weapons type allows for the class
@export var magicUser: bool ## Is the character can use magic
@export var ability: String ## Which ability the class add to the gameplay (NYI & TODO)
@export var description: String ## Description for character creation

func _init(givenClass: Classes) -> void:
    var file = FileAccess.open("res://game/assets/data/classes.json", FileAccess.READ)
    var content = file.get_as_text()
    var result = JSON.parse_string(content)
    
    var classAttributes: Dictionary;
    match givenClass:
        Classes.ASSASSIN:
            classAttributes = result["assassin"]
        Classes.BARBARIAN:
            classAttributes = result["barbarian"]
        Classes.BATTLEMAGE:
            classAttributes = result["battlemage"]
        Classes.KNIGHT:
            classAttributes = result["knight"]
        Classes.NIGHTBLADE:
            classAttributes = result["nightblade"]
        Classes.ROGUE:
            classAttributes = result["rogue"]
        Classes.SORCERER:
            classAttributes = result["sorcerer"]
        Classes.SPELLSWORD:
            classAttributes = result["spellsword"]
        Classes.THIEF:
            classAttributes = result["thief"]
        _:
            print("Unexpected class given")
            return

    charClass = givenClass
    charGuild = strToGuild(classAttributes["guild"])
    armorType = dictToArmor(classAttributes["armor"])
    shieldType = dictToArmor(classAttributes["shield"])
    weaponType = dictToWeapon(classAttributes["weapon"])
    magicUser = classAttributes["magic"]
    ability = classAttributes["ability"]
    description = classAttributes["description"]

func strToGuild(rawGuild: String) -> Guilds:
    if(rawGuild == "fighter"):
        return Guilds.FIGHTER
    elif(rawGuild == "mage"):
        return Guilds.MAGE
    elif(rawGuild == "thieves"):
        return Guilds.THIEVES
    else:
        return Guilds.FIGHTER

func dictToArmor(rawArmors: Array) -> Array[ItemListEnum.ArmorCategories]:
    var armor: Array[ItemListEnum.ArmorCategories] = []
    for raw in rawArmors:
        if(raw == "light"):
            armor.append(ItemListEnum.ArmorCategories.LIGHT)
        elif(raw == "medium"):
            armor.append(ItemListEnum.ArmorCategories.MEDIUM)
        elif(raw == "heavy"):
            armor.append(ItemListEnum.ArmorCategories.HEAVY)
    return armor

func dictToWeapon(rawWeapons: Array) -> Array[ItemListEnum.ItemType]:
    var weapon: Array[ItemListEnum.ItemType] = []
    for raw in rawWeapons:
        if(raw == "axe"):
            weapon.append(ItemListEnum.ItemType.AXE)
        elif(raw == "blunt"):
            weapon.append(ItemListEnum.ItemType.BLUNT)
        elif(raw == "club"):
            weapon.append(ItemListEnum.ItemType.CLUB)
        elif(raw == "lightbow"):
            weapon.append(ItemListEnum.ItemType.LIGHTBOW)
        elif(raw == "longblade"):
            weapon.append(ItemListEnum.ItemType.LONGBLADE)
        elif(raw == "mediumbow"):
            weapon.append(ItemListEnum.ItemType.MEDIUMBOW)
        elif(raw == "shorblade"):
            weapon.append(ItemListEnum.ItemType.SHORTBLADE)
        elif(raw == "thrown"):
            weapon.append(ItemListEnum.ItemType.THROWN)
    return weapon