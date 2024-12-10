extends Node3D

@export var PLAYER:CharacterBody3D

@export var RAT_SCENE:PackedScene = preload("res://pre_fabs/rat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = 8
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_timed_spawner)
	spawn_timer.autostart = true
	add_child(spawn_timer)
	spawn_enemies(20)

func _process(delta: float) -> void:
	pass

func _timed_spawner():
	spawn_enemies(5) 

func spawn_enemies(count:int):
	for i in range(count):
		spawn_enemy(Enemy_Type.Rat)
		
func spawn_enemy(enemy_type):
	var location = get_spawn_location()
	var enemy
	match enemy_type:
		Enemy_Type.Rat:
			enemy = RAT_SCENE.instantiate()
			enemy.initialize(PLAYER, location)
			$Enemies/Rats.add_child(enemy)

func get_spawn_location() -> Vector3:
	var total_top_left = $plane/Top_left.global_position
	var total_bottom_right = $plane/Bottom_right.global_position
	var anti_top_left = $Player/Spawning_Cylinders/Anti_top_left.global_position
	var anti_bottom_right = $Player/Spawning_Cylinders/Anti_bottom_right.global_position

	var point := Vector3(randf_range(total_top_left.x, total_bottom_right.x), 0, randf_range(total_top_left.z, total_bottom_right.z))
	while is_in_square(point, anti_top_left, anti_bottom_right):
		point = Vector3(randf_range(total_top_left.x, total_bottom_right.x), 0, randf_range(total_top_left.z, total_bottom_right.z))

	return point

func is_in_square(point, corn1, corn2) -> bool:
	return (corn1.x < point.x and corn2.x > point.x and corn1.z < point.z and corn2.z > point.z)
