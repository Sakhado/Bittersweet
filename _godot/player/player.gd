extends Node3D

@onready var controller = $player_character
@onready var camera = $player_character/player_head/player_camera
@onready var stored_pos = global_position
@onready var player_timer = $player_character/player_timer
@onready var raycast = $player_character/player_head/player_camera/player_cast

var is_interacting = false
var is_active = true
var in_bed = false
var target = null

func deactivate_player():
	controller.is_active = false
	is_active = false

func activate_player():
	camera.make_current()
	controller.is_active = true
	is_active = true

func _process(delta):
	target = raycast.get_collider()
	if Input.is_action_just_pressed("interact"):
		is_interacting = true
	else:
		is_interacting = false
