extends Node

# &"quest name": [current_quest_stage, [dialogs]]
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
	
