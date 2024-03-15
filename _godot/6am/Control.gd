extends Control

@onready var eye = $AnimatedSprite2D

func eye_animation():
	eye.play("default")
