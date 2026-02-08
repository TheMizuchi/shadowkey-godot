class_name SaveGame
extends Resource

const SAVE_GAME_PATH = "user://save.tres"

@export var version:int = 1

@export var inventory: Dictionary
@export var current_equip: String

@export var global_position: Vector3 = Vector3.ZERO
@export var global_rotation: Vector3 = Vector3.ZERO

@export var player_name: String
@export var player_gender: bool
@export var player_race: PlayerStats.Races
@export var player_class: PlayerStats.Classes
@export var player_attr: Dictionary


@export var level_name: String = ""

func write_save() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)


static func load_save() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH)
