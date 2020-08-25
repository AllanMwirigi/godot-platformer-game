extends "res://src/Actors/Actor.gd"

# called by godot on every node in the scene starting from the one deepest in the tree
# allows us to set up the enemy
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

# callback/signal when a body enters the stomp area
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y >= get_node("StompDetector").global_position.y:
		# if player enters from a position lower than stomp area, don't do anything, > used because y-axis increases downwards 
		return
	get_node("CollisionShape2D").disabled = true # prevent player from dying when it touches the enemy
	queue_free() # kill the enemy i.e. delete the node

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		# change direction of enemy if it collides with a wall, at whatever velocity it had i.e. factor of 1
		_velocity.x *= -1.0  
	
	# only y component modified to prevent x from being reset to 0 by move_and_slide when enemy collides with wall/player
	# want to maintain the same x that was there, just in the other direction
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y 


