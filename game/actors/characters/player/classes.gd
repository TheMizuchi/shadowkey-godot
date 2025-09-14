enum Classes {ASSASSIN, BARBARIAN, BATTLEMAGE, KNIGHT, NIGHTBLADE, ROGUE, SORCERER, SPELLSWORD, THIEF}
enum Guilds {FIGHTER, MAGE, THIEVES}

const ItemListEnum = preload("res://game/game_logic/item_list.gd")

var charClass: Classes ## Which class the character has
var charGuild: Guilds ## Which type of class 
var armorType: Array[ItemListEnum.ArmorCategories] = [] ## Armors type allows for the class
var shieldType: Array[ItemListEnum.ArmorCategories] = [] ## Shield type allows for the class
var weaponType: Array[ItemListEnum.ItemType] = [] ## Weapons type allows for the class
var magicUser: bool ## Is the character can use magic
var ability: String ## Which ability the class add to the gameplay (NYI & TODO)

func _init(givenClass: Classes) -> void:
    match givenClass:
        Classes.ASSASSIN:
            charClass = givenClass
            charGuild = Guilds.THIEVES
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            shieldType.append_array([])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = false
            ability = "Lethal Strike"
        Classes.BARBARIAN:
            charClass = givenClass
            charGuild = Guilds.FIGHTER
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM, ItemListEnum.ArmorCategories.HEAVY])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = false
            ability = "Barbarian's Rage"
        Classes.BATTLEMAGE:
            charClass = givenClass
            charGuild = Guilds.MAGE
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            shieldType.append_array([[ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM]])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = true
            ability = "Mystic Might"
        Classes.KNIGHT:
            charClass = givenClass
            charGuild = Guilds.FIGHTER
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM, ItemListEnum.ArmorCategories.HEAVY])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM, ItemListEnum.ArmorCategories.HEAVY])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = false
            ability = "Righteous Will"
        Classes.NIGHTBLADE:
            charClass = givenClass
            charGuild = Guilds.THIEVES
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            weaponType.append_array([ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = true
            ability = "Night Magic"
        Classes.ROGUE:
            charClass = givenClass
            charGuild = Guilds.FIGHTER
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM, ItemListEnum.ArmorCategories.HEAVY])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = false
            ability = "Rogue's Dodge"
        Classes.SORCERER:
            charClass = givenClass
            charGuild = Guilds.MAGE
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM])
            shieldType.append_array([])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = true
            ability = "Sorcery"
        Classes.SPELLSWORD:
            charClass = givenClass
            charGuild = Guilds.MAGE
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT, ItemListEnum.ArmorCategories.MEDIUM])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.BLUNT,
                                        ItemListEnum.ItemType.CLUB,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.MEDIUMBOW,
                                        ItemListEnum.ItemType.SHORTBLADE,
                                        ItemListEnum.ItemType.THROWN,])
            magicUser = true
            ability = "Precise Magic"
        Classes.THIEF:
            charClass = givenClass
            charGuild = Guilds.THIEVES
            armorType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            shieldType.append_array([ItemListEnum.ArmorCategories.LIGHT])
            weaponType.append_array([ItemListEnum.ItemType.AXE,
                                        ItemListEnum.ItemType.LIGHTBOW,
                                        ItemListEnum.ItemType.LONGBLADE,
                                        ItemListEnum.ItemType.SHORTBLADE])
            magicUser = false
            ability = "Thief Lore"
        _:
            print("Unexpected class given")

