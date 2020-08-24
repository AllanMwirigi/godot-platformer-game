# both player and enemy will inherit from this class
extends KinematicBody2D
class_name Actor # allows it to be inherited i.e. in other file - extends {class_name}

export var speed: = Vector2(800.0, 1000.0) # the max velocity
#var velocity: = Vector2(300, 0) #move 300px/s on x-axis and 0px/s on y-axis
export var _velocity: = Vector2.ZERO # initial velocity is zero, underscore denotes private variable to only be modified in this class and children
export var gravity: = 3000.0	# export used to make value configurable from editor
# gravity defines the acceleration by which the actor falls in pixels/sec

const FLOOR_NORMAL: = Vector2.UP # to define direction when jumping

#this is an inbuilt func which when included in node, will be called in every frame
#put player movements here
#there is also _process, hv use this instead as we are dealing with motion and collision
#func _physics_process(delta: float) -> void:
	# delta is a value given by engine on every tick of this function
		#reps the time elapsed since the previous frame, 
		# ensures consistency based on the speed of user's device
	
	# velocity.y = min(velocity.y, speed.y)  #caps the max fall velocity to speed
	

	
	
	
	
	
	