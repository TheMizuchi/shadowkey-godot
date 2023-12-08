extends Node

# &"quest name": [current_quest_stage, [dialogs]]

func _ready():
	add_all_quests()

class Quest:
	var name
	var current_stage = 0

	func _init(quest_name):
		name = quest_name
	
	func set_stage(stage):
		current_stage = stage
	
	func progress_quest():
		current_stage += 1

var new_quest_list = {}

var quests = {&"Broken Wing Cameo" : [0, []], \
	&"Bribery Papers" : [0, []], \
	&"Blue Raider Mission" : [0, []], \
	&"Collect Five Star Teeth" : [0, []], \
	&"Clear Earthtear Caverns" : [0, []], \
	&"Clerk Skye's Items" : [0, []], \
	&"Caretaker Rescue" : [0, []], \
	&"Disgruntled Thief" : [0, []], \
	&"Dragonstar Gate Clear Hill" : [0, []], \
	&"East Gate Raider Spree" : [0, []], \
	&"Find Azra Nightwielder" : [0, []], \
	&"Find the Temple" : [0, []], \
	&"Goblin Rescue 1" : [0, []], \
	&"Goblin Rescue 2" : [0, []], \
	&"Gold Raider Mission" : [0, []], \
	&"Herbs for Rilora" : [0, []], \
	&"Herb Quest" : [0, []], \
	&"Mage's Identity" : [0, []], \
	&"Makor's Deal" : [0, []], \
	&"Porliss Thieves' Guild" : [0, []], \
	&"Porliss Loth' Na" : [0, []], \
	&"Prisoner Assassin" : [0, []], \
	&"Prisoner Family" : [0, []], \
	&"Pilgrim Ghost Party" : [0, []], \
	&"Pilgrim Ghost Ring" : [0, []], \
	&"Porliss Caith Subterfuge" : [0, []], \
	&"Porliss Lakvan Evidence" : [0, []], \
	&"Prisoner Locket" : [0, []], \
	&"Rescue Prisoners" : [0, []], \
	&"Rilora Message" : [0, []], \
	&"Red Raider Mission" : [0, []], \
	&"Rogurin Letter of Introduction" : [0, []], \
	&"Rat Quest" : [0, []], \
	&"Skyrim Sympathizer's Map" : [0, []], \
	&"Sergeant Deal" : [0, []], \
	&"Sissithik's Will" : [0, []], \
	&"Trailslag's Goods" : [0, []], \
	&"Tanyin Lakvan Evidence" : [0, []], \
	&"Tanyin Goblin Raid" : [0, []], \
	&"Tanyin Mages' Guild" : [0, []], \
	&"Temple Herbs" : [0, []], \
	&"Tanyin Prisoner Free" : [0, []], \
	&"Volstok Violet Resurrection" : [0, []], \
	&"Witch Tree 1" : [0, []], \
	&"Witch Tree 2" : [0, []], \
	&"Witch Tree 3": [0, []]
}

func add_quest(id, name):
	var quest = Quest.new(name)
	new_quest_list[id] = quest

func add_all_quests():
	add_quest(&"brokenwingcameo", "Broken Wing Cameo")
	add_quest(&"briberypapers", "Bribery Papers")
	add_quest(&"blueraidermission", "Blue Raider Mission")
	add_quest(&"collectfivestarteeth", "Collect Five Star Teeth")
	add_quest(&"clearearthtearcaverns", "Clear Earthtear Caverns")
	add_quest(&"clerkskyesitems", "Clerk Skye's Items")
	add_quest(&"caretakerrescue", "Caretaker Rescue")
	add_quest(&"disgruntledthief", "Disgruntled Thief")
	add_quest(&"dragonstargateclearhill", "Dragonstar Gate Clear Hill")
	add_quest(&"eastgateraiderspree", "East Gate Raider Spree")
	add_quest(&"findazranightwielder", "Find Azra Nightwielder")
	add_quest(&"findthetemple", "Find the Temple")
	add_quest(&"goblinrescue1", "Goblin Rescue 1")
	add_quest(&"goblinrescue2", "Goblin Rescue 2")
	add_quest(&"goldraidermission", "Gold Raider Mission")
	add_quest(&"herbsforrilora", "Herbs for Rilora")
	add_quest(&"herbquest", "Herb Quest")
	add_quest(&"magesidentity", "Mage's Identity")
	add_quest(&"makorsdeal", "Makor's Deal")
	add_quest(&"porlissthievesguild", "Porliss Thieves' Guild")
	add_quest(&"porlisslothna", "Porliss Loth' Na")
	add_quest(&"prisonerassassin", "Prisoner Assassin")
	add_quest(&"prisonerfamily", "Prisoner Family")
	add_quest(&"pilgrimghostparty", "Pilgrim Ghost Party")
	add_quest(&"pilgrimghostring", "Pilgrim Ghost Ring")
	add_quest(&"porlisscaithsubterfuge", "Porliss Caith Subterfuge")
	add_quest(&"porlisslakvanevidence", "Porliss Lakvan Evidence")
	add_quest(&"prisonerlocket", "Prisoner Locket")
	add_quest(&"rescueprisoners", "Rescue Prisoners")
	add_quest(&"riloramessage", "Rilora Message")
	add_quest(&"redraidermission", "Red Raider Mission")
	add_quest(&"rogurinletterofintroduction", "Rogurin Letter of Introduction")
	add_quest(&"ratquest", "Rat Quest")
	add_quest(&"skyrimsympathizersmap", "Skyrim Sympathizer's Map")
	add_quest(&"sergeantdeal", "Sergeant Deal")
	add_quest(&"sissithikswill", "Sissithik's Will")
	add_quest(&"trailslagsgoods", "Trailslag's Goods")
	add_quest(&"tanyinlakvanevidence", "Tanyin Lakvan Evidence")
	add_quest(&"tanyingoblinraid", "Tanyin Goblin Raid")
	add_quest(&"tanyinmagesguild", "Tanyin Mages' Guild")
	add_quest(&"templeherbs", "Temple Herbs")
	add_quest(&"tanyinprisonerfree", "Tanyin Prisoner Free")
	add_quest(&"volstokvioletresurrection", "Volstok Violet Resurrection")
	add_quest(&"witchtree1", "Witch Tree 1")
	add_quest(&"witchtree2", "Witch Tree 2")
	add_quest(&"witchtree3", "Witch Tree 3")

func get_quest_stage(quest_name):
	return quests[quest_name][0]

func set_quest_stage(quest_name, stage):
	quests[quest_name][0] = stage
	print(quest_name, " ", stage)

func progress_quest(quest_name):
	# TODO: somehow check requirements for quest progress
	if true:
		set_quest_stage(quest_name, get_quest_stage(quest_name)+1)
		return true
	return false
	
