extends Area3D

signal hit(hitter)

func _physics_process(delta: float) -> void:
	for collision in get_overlapping_bodies():
		hit.emit(collision)
