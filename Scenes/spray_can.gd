extends Node2D


const COOLDOWN_MS = 400

var last_shot_time = -401

@onready var pressed_sprite = $Pressed
@onready var unpressed_sprite = $Unpressed
@onready var particles = $CPUParticles2D

func _ready():
	pass

func _process(_delta):
	if !get_meta("usable"):
		return
	
	if Input.is_action_pressed("shoot") && is_cooldown_over():
		last_shot_time = Time.get_ticks_msec()
	
	if is_cooldown_over():
		particles.emitting = false
		pressed_sprite.visible = false
		unpressed_sprite.visible = true
	else:
		particles.emitting = true
		pressed_sprite.visible = true
		unpressed_sprite.visible = false

func is_cooldown_over():
	return Time.get_ticks_msec() > last_shot_time + COOLDOWN_MS
