class_name Enemy
extends CharacterBody3D


const SPEED := 2.0
const JUMP_VELOCITY := 4.5
var target:CharacterBody3D 

var HEALTH:float = 100

func initialize(player:CharacterBody3D, start_pos:Vector3):
	target = player
	look_at_from_position(start_pos, start_pos + Vector3.FORWARD)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := global_position.direction_to(target.global_position)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.z)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if direction != Vector3.ZERO:
		$Pivot.basis = Basis.looking_at(direction)

	move_and_slide()

func take_damage(damage_amount:float):
	HEALTH -= damage_amount
	
	if HEALTH <= 0:
		get_parent().remove_child(self)
