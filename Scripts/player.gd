extends CharacterBody2D


const SPEED = 300.0
const SPRINT_MULTIPLIER = 1.6

func _process(_delta):
	rotation = position.angle_to_point(get_viewport().get_mouse_position()) + PI / 2.0

func _physics_process(_delta):
	var speed = SPEED
	
	if Input.is_action_pressed("sprint"):
		speed = speed * SPRINT_MULTIPLIER
		
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	
	var combined_direction = sqrt(
		x_direction * x_direction + y_direction * y_direction
		)
	if combined_direction > 1:
		x_direction /= combined_direction
		y_direction /= combined_direction
	
	if x_direction:
		velocity.x = x_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if y_direction:
		velocity.y = y_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
