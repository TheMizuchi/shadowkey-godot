extends Node

@export var red_material_path = ""
var red_material
var meshes = []
#var material
var damage_indicator_timer = Timer.new()

func _ready():
	red_material = load(red_material_path)
	find_meshes()
	#if meshes:
		#material = meshes[0].mesh.surface_get_material(0)
	set_up_timer()

func set_up_timer():
	damage_indicator_timer.one_shot = true
	damage_indicator_timer.wait_time = 0.2
	damage_indicator_timer.timeout.connect(clear_red)
	add_child(damage_indicator_timer)

func find_meshes():
	for node in get_parent().get_children():
		if node is Node3D:
			for node2 in node.get_children():
				if node2 is MeshInstance3D:
					meshes.append(node2)

func paint_red():
	set_material(red_material)
	damage_indicator_timer.start()

func clear_red():
	set_material()

func set_material(material=null):
	for mesh_node in meshes:
		mesh_node.material_override = material
