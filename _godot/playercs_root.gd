extends Node3D

@onready var controller = $player_character
@onready var camera = $player_character/player_head/player_camera
@onready var stored_pos = global_position
@onready var player_timer = $player_character/player_timer

var is_interacting = false
var is_active = false
var in_bed = false

func pass_mouse_input(rot):
	controller.rot = rot
	
func deactivate_player():
	controller.is_active = false
	is_active = false

func activate_player():
	is_active = true
	controller.is_active = true

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		is_interacting = true
	else:
		is_interacting = false
