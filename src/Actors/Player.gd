extends Actor

# this and the parent's physics_process will be called
func _physics_process(delta: float) -> void:
	var direction: = getDirection()
	velocity = calculateMoveVelocity(velocity, direction, speed) # velocity and speed are from Actor
	#to make body move, use this func defined in KinematicBody2D
	# it returns a new velocity vector
	# also calculates a rotated/scaled new velocity if char hits a wall/object in order to smooth the motion along the surface that it hit
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	
func getDirection() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0 		
#		Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
		# -1.0 allows player to jump (y-axis increases downwards), 1.0 makes player fall
	)
	
func calculateMoveVelocity(linearVelocity: Vector2, direction: Vector2, speed: Vector2) -> Vector2:
	var newVelocity: = linearVelocity
	newVelocity.x = speed.x * direction.x
	newVelocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		newVelocity.y = speed.y * direction.y
	return newVelocity