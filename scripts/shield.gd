class_name Shield
extends Item


const BASH_VELOCITY = 3000
const COOLDOWN_MS = 1600

var last_bash_time = -1601

func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("bash") && is_cooldown_over():
		last_bash_time = Time.get_ticks_msec()
		if get_parent() is Hand && get_parent().get_parent() is CharacterBody2D:
			var player = get_parent().get_parent()
			var player_rotation = player.rotation - PI / 2.0
			player.velocity = Vector2(
				cos(player_rotation) * BASH_VELOCITY,
				sin(player_rotation) * BASH_VELOCITY
				)


func is_cooldown_over():
	return Time.get_ticks_msec() > last_bash_time + COOLDOWN_MS
