extends Node

# TODO: figure out quest stage matrix
# should quest stage dialogues start at 1?

# TODO: figure out how to handle cont tracking
# rats killed, refugees helped, etc

var quests = {}
var dialogues
var player

func _ready():
	dialogues = $"../dialogues".dialogues
	player = %player
	add_all_quests()

func _on_opponent_death(ennemy_name):
	for quest_id in quests:
		var quest = quests.get(quest_id)
		if quest.mob_requirement && quest.mob_requirement.get(quest.current_stage):
			var mob_complete = 0
			var current_mobs = quest.mob_requirement.get(quest.current_stage)
			for mob in current_mobs.keys():
				if mob == ennemy_name && current_mobs.get(mob)[0] != current_mobs.get(mob)[1]:
					current_mobs.get(mob)[0]+=1
					print("death ", ennemy_name, " num ", current_mobs.get(mob)[0])
				if(current_mobs.get(mob)[0] == current_mobs.get(mob)[1]):
					mob_complete += 1
			if mob_complete == current_mobs.size():
				progress_quest(quest_id)

class Quest:
	var name
	var current_stage = 0
	var completion_stages = []
	var stage_rewards = {}
	var next_stages = {}
	var stage_dialogues = {}
	var mob_requirement = {}
	var xp = 0
	var completed = false
	
	signal complete_quest(xp, reward)

	func _init(quest_name):
		name = quest_name
	
	func get_stage():
		return current_stage
	
	func set_stage(stage):
		current_stage = stage
		if current_stage in completion_stages:
			completed = true
			complete_quest.emit(xp, stage_rewards[current_stage])
	
	func add_stage_reward(stage, rewards):
		stage_rewards[stage] = rewards
	
	func add_stage_dialogue(stage, dialogue):
		stage_dialogues[stage] = dialogue
	
	func progress_quest():
		#TODO: can this even initiate dialogue?
		if(current_stage in next_stages):
			current_stage = next_stages[current_stage]
		else:
			current_stage += 1
		if current_stage in completion_stages:
			completed = true
			complete_quest.emit(xp, stage_rewards.get(current_stage))

func add_quest(id,
				name,
				completion_stages=[],\
				stage_rewards={}, 
				next_stages={},
				stage_dialogues={}, 
				mob_requirement={},
				xp=0):
	var quest = Quest.new(name)
	for index in completion_stages:
		quest.completion_stages.append(index)
	for key in stage_rewards.keys():
		quest.stage_rewards[key] = stage_rewards[key]
	for key in stage_dialogues.keys():
		quest.stage_dialogues[key] = stage_dialogues[key]
	for key in mob_requirement.keys():
		quest.mob_requirement[key] = mob_requirement[key]
	quests[id] = quest
	quest.xp = xp
	quest.next_stages = next_stages
	quest.connect(&"complete_quest", player.reward_quest)

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
	add_quest(&"findthetemple", "Find the Temple", [3],{},
	{1: dialogues[1559], 2: dialogues[1589], 3: dialogues[1590]})
	add_quest(&"goblinrescue1", "Goblin Rescue 1")
	add_quest(&"goblinrescue2", "Goblin Rescue 2")
	add_quest(&"goldraidermission", "Gold Raider Mission")
	add_quest(&"herbsforrilora", "Herbs for Rilora")
	add_quest(&"herbquest", "Herb Quest", [], {}, \
	{2: dialogues[1231], 3:dialogues[1230]})
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
	add_quest(&"ratquest", "Rat Quest", [], {}, {}, {0: {"rat": [0, 8], "bandit_brawler": [0, 1]}})
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
	return quests[quest_name].current_stage

func is_quest_completed(quest_name):
	return quests[quest_name].completed

func set_quest_stage(quest_name, stage):
	quests[quest_name].set_stage(stage)
	check_for_new_dialogue(quest_name)
	print(quests[quest_name].name, " was set to stage ", stage)

func check_for_new_dialogue(quest_name):
	var current_quest_stage = quests[quest_name].get_stage()
	if current_quest_stage in quests[quest_name].stage_dialogues.keys():
		%dialogue_menu.show_dialogue(quests[quest_name].stage_dialogues[current_quest_stage])

func progress_quest(quest_name):
	# TODO: somehow check requirements for quest progress
	if true:
		# assume quest accepted? TODO: figure this stuff out
		#if quests[quest_name].get_stage() > 0:
		# TODO: check this stuff properly
		quests[quest_name].progress_quest()
		check_for_new_dialogue(quest_name)
		print(quests[quest_name].name, " progresed to stage ", quests[quest_name].get_stage())
		return true
	return false
	
