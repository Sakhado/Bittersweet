extends Node3D

@onready var player = $"../player_main"
@onready var csplayer = $"../SubViewport/csplayer"
@onready var camera = $Camera3D

var is_active = false

func _process(delta):
	if player.target:
		print(player.target.name)
	if player.target and Input.is_action_just_pressed("interact") and player.target.name == "monitor_area" and !is_active:
		player.deactivate_player()
		csplayer.activate_player()
		camera.make_current()
		is_active = true
	elif Input.is_action_just_pressed("interact") and is_active:
		print("here")
		player.activate_player()
		csplayer.deactivate_player()
		is_active = false
	
	
