extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera = $player_head/player_camera
@onready var head = $player_head
@onready var label = $Label

var is_active = true
var is_interacting = false

# Player speed
var SPEED = 2

var rot = Vector2.ZERO # Stores the relative mouse input multiplied by the sensitivity
var sens = .1          # Mouse sensitvity

func _unhandled_input(event):
	# If mouse input detected
	if event is InputEventMouseMotion:
		rot -= event.relative * sens   # Finds the relative mouse movement since the previous frame, multiplied by the sensitivity
		print(rot)
		if abs(rot.x) > 360:
			rot.x = 0                  # If the x rotation is greater than 360 degrees, set it to 0
		if abs(rot.y) > 89.9:
			rot.y = sign(rot.y) * 89.9 # If the y rotation is greater than 89.9 degrees, set it to either +89.9 or -89.9

func _physics_process(delta):
	
	if is_active == false:
		return

	# Sets the rotation in degrees for the head (and camera)
	head.rotation_degrees.x = rot.y
	# Sets the rotation degrees for the player
	rotation_degrees.y = rot.x
	
	# Applying gravity
	if not is_on_floor():                    # Detects a collision of a floor
		velocity.y -= (gravity * delta)      # Then constantly subtract from y velocity (subtracting gravity multiplied by the time since the previous frame)

	# Vector2 storing positive or negative x and y values indicating the direction of movement
	var input_dir = Input.get_vector("left","right","forward","back") # -x +x -y +y

	# A unit vector of the direction as indicated by the input_dir, the confusing part of this one is setting the Z value to input_dir.y -- input_dir.y is merely a value in a 2D vector, has nothing to do with direction.y
	var direction = (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized() 
	
	# If direction is not 0
	if direction:
		velocity.x = direction.x * SPEED # Set the direction
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,1) # Essentially interpolates from the velocity, towards zero by the amount in arg3
		velocity.z = move_toward(velocity.z,0,1)
		
	move_and_slide() # Moves body based on the velocity, will slide along a body if collided -- returns true if body collided, otherwise falsee
