extends Node3D

@onready var csplayer = $SubViewport/csplayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

var rot = Vector2.ZERO
var sens = .1          # Mouse sensitvity

func _unhandled_input(event):
	# If mouse input detected
	if csplayer.is_active:
		if event is InputEventMouseMotion:
			rot -= event.relative * sens   # Finds the relative mouse movement since the previous frame, multiplied by the sensitivity
			if abs(rot.x) > 360:
				rot.x = 0                  # If the x rotation is greater than 360 degrees, set it to 0
			if abs(rot.y) > 89.9:
				rot.y = sign(rot.y) * 89.9 # If the y rotation is greater than 89.9 degrees, set it to either +89.9 or -89.9

func _input(event):
	if Input.is_action_pressed("close"):
		get_tree().quit()
	if Input.is_action_pressed("fullscreen"):
		DisplayServer.window_set_mode(3)
		
		
func _process(delta):
	if csplayer.is_active:
		csplayer.pass_mouse_input(rot)
