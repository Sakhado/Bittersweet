extends Camera3D

var rot_original = rotation_degrees.y

var rot = Vector2.ZERO # Stores the relative mouse input multiplied by the sensitivity
var sens = .05          # Mouse sensitvity

func _unhandled_input(event):
	# If mouse input detected
	if event is InputEventMouseMotion:
		rot -= event.relative * sens   # Finds the relative mouse movement since the previous frame, multiplied by the sensitivity
		if abs(rot.x) > 360:
			rot.x = 0                  # If the x rotation is greater than 360 degrees, set it to 0
		elif rot.x > 45:
			rot.x = 45
		elif rot.x < -45:
			rot.x = -45

func _process(delta):
	if current:
		rotation_degrees.y = rot.x
	else:
		rotation_degrees.y = rot_original
		rot.x = rot_original
