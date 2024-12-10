extends Area3D

signal hit(hit_group)

func _physics_process(delta: float) -> void:
	for collision in get_overlapping_bodies():
		if collision.is_in_group("RAT"):
			hit.emit(Enemy_Type.Rat)
