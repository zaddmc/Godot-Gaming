extends Node3D

@onready var PLAYER = $Player
enum Enemy_Type {Rat}

var RAT = preload("res://pre_fabs/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("spawn_enemies")

func _process(delta: float) -> void:
	print(get_spawn_location())

func spawn_enemies():
	for i in range(20):
		spawn_enemy(Enemy_Type.Rat)
		
func spawn_enemy(enemy_type:Enemy_Type):
	var location = get_spawn_location()
	var enemy
	match enemy_type:
		Enemy_Type.Rat:
			enemy = RAT.instantiate()
			enemy.initialize(PLAYER, location)
			$Enemies/Rats.add_child(enemy)

func get_spawn_location() -> Vector3:
	#var player_position = PLAYER.global_position
	
	var total_top_left = $plane/Top_left.global_position
	var total_bottom_right = $plane/Bottom_right.global_position
	var anti_top_left = $Player/Spawning_Cylinders/Anti_top_left.global_position
	var anti_bottom_right = $Player/Spawning_Cylinders/Anti_bottom_right.global_position

	var x_range = [total_top_left.x, anti_top_left.x, total_bottom_right.x, anti_bottom_right.x]
	var y_range = [total_top_left.z, anti_top_left.z, total_bottom_right.z, anti_bottom_right.z]
	
	var x_vals = []
	if x_range[0] - x_range[1] < 0:
		x_vals.append(randf_range(x_range[0], x_range[1]))
	if x_range[2] - x_range[3] > 0:
		x_vals.append(randf_range(x_range[2], x_range[3]))
	var y_vals = []
	if y_range[0] - y_range[1] < 0:
		y_vals.append(randf_range(y_range[0], y_range[1]))
	if y_range[2] - y_range[3] > 0:
		y_vals.append(randf_range(y_range[2], y_range[3]))
	
	
	return Vector3(x_vals.pick_random(), 0, y_range.pick_random())
