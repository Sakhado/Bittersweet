extends Node3D

@onready var camera = $bed_camera
@onready var player = $"../player_main"
@onready var timer = $bed_timer
@onready var control = $bed_camera/Control
@onready var monitor = $"../monitor"


var player_in_area = false

func _on_area_3d_body_entered(body):
	if body.name == "player_character":
		player_in_area = true

func _on_area_3d_body_exited(body):
	if body.name == "player_character":
		player_in_area = false


func _process(delta):
	if (player_in_area and player.is_interacting) and !player.in_bed:
		camera.make_current()
		player.deactivate_player()
		player.in_bed = true
		timer.start(.5)
	
	elif (player.in_bed and player.is_interacting) and !timer.time_left:
		player.in_bed = false
		player.activate_player()
