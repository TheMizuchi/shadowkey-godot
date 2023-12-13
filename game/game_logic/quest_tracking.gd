extends Node

var quests = {}

func _ready():
	add_all_quests()

# TODO: decide in rewards_dict structure
class Quest:
	var name
	var current_stage = 0
	var completion_stages = []
	var stage_rewards = {}
	var stage_dialogues = {}
	var completed = false

	func _init(quest_name):
		name = quest_name
	
	func get_stage():
		return current_stage
	
	func set_stage(stage):
		current_stage = stage
		if current_stage in completion_stages:
			completed = true
	
	func add_stage_reward(stage, rewards):
		stage_rewards[stage] = rewards
	
	func add_stage_dialogue(stage, dialogue):
		stage_dialogues[stage] = dialogue
	
	func progress_quest():
		current_stage += 1
		if current_stage in completion_stages:
			completed = true

func add_quest(id, name, completion_stages=[],\
	stage_rewards={}, stage_dialogues={}):
	var quest = Quest.new(name)
	for index in completion_stages:
		quest.completion_stages.append(index)
	for key in stage_rewards.keys():
		quest.stage_rewards[key] = stage_rewards[key]
	for key in stage_dialogues.keys():
		quest.stage_dialogues[key] = stage_dialogues[key]
		
	
	quests[id] = quest

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
	quests[quest_name].set_stage(stage)
	print(quest_name, " ", stage)

func progress_quest(quest_name):
	# TODO: somehow check requirements for quest progress
	if true:
		quests[quest_name].progress_quest()
		print(quests[quest_name].name, " is now at stage ", quests[quest_name].get_stage())
		return true
	return false
	
