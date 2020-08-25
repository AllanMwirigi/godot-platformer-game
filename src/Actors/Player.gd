extends Actor

export var stomp_impulse: = 800.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculateStompVelocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	queue_free() # kill the player if collides with enemy

# this and the parent's physics_process will be called
func _physics_process(delta: float) -> void:
	var isJumpInterrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = getDirection()
	_velocity = calculateMoveVelocity(_velocity, direction, speed, isJumpInterrupted) # velocity and speed are from Actor
	#to make body move, use this func defined in KinematicBody2D
	# it returns a new velocity vector
	# also calculates a rotated/scaled new velocity if char hits a wall/object in order to smooth the motion along the surface that it hit
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	
func getDirection() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0 		
#		Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
		# -1.0 allows player to jump (y-axis increases downwards), 1.0 makes player fall
	)
	
func calculateMoveVelocity(linearVelocity: Vector2, direction: Vector2, speed: Vector2, isJumpInterrupted: bool) -> Vector2:
	var newVelocity: = linearVelocity
	# if key not pressed/both L/R pressed, direction.x is 0.0 thus newvelocity.x is 0.0; direction vector obtained from getDirection
	# if key pressed hence direction.x has value, speed.x will be multiplied by a factor in the range of 0 to 1, in the right direction
	newVelocity.x = speed.x * direction.x 
	
	# this makes player fall if above floor e.g. when jumping or at start of game
	newVelocity.y += gravity * get_physics_process_delta_time() 
	
	if direction.y == -1.0:
		newVelocity.y = speed.y * direction.y
	if isJumpInterrupted:
		newVelocity.y = 0.0 # if jump key is released mid jump, stop the jump i.e. jump smaller height on light press
	return newVelocity
	
func calculateStompVelocity(linearVelocity: Vector2, impulse: float) -> Vector2:
	var out: = linearVelocity
	out.y = -impulse # replace y component with the defined value for a bounce effect i.e. player jumps a bit after stomping
	return out

