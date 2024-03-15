extends RayCast3D

var original_pos = target_position

@onready var label = $"../../../Label"
@onready var hand = $"../player_held"
@onready var player = $"../../../.."
@onready var camera = $".."

var target

func _process(delta):
	if is_colliding():
		target = get_collider()

