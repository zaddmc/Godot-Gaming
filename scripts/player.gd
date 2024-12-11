extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5

var HEALTH:float = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if direction != Vector3.ZERO:
		$Pivot.basis = Basis.looking_at(direction)
	#collision_detector()
	move_and_slide()

func collision_detector():
	# Probably redundant
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().name == "plane":
			continue
		print(collision.get_collider().name)

func _on_area_3d_hit(hitter:Enemy) -> void:
	HEALTH -= 5
	print(HEALTH)
	
	hitter.take_damage(10)
	
