extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5
var target 

func initialize(player, start_pos):
	target = player
	#print(start_pos)
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
