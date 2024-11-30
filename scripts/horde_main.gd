extends Node3D

@onready var PLAYER = $Player
enum Enemy_Type {Rat}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello")
	
	spawn_enemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_enemies():
	for i in range(20):
		spawn_enemy(Enemy_Type.Rat)
		
func spawn_enemy(enemy_type:Enemy_Type):
	var location = $Spawning_Cylinders/Spawn_Path/Spawn_Location
	location.set_progress_ratio(randf())

	var enemy
	match enemy_type:
		Enemy_Type.Rat:
			enemy = load("res://pre_fabs/enemy.tscn").instantiate()
	
	enemy.initialize(PLAYER, location.global_position)
	add_child(enemy)
