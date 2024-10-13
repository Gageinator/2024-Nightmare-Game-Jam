extends CharacterBody2D

@export var SPEED = 300

func _ready() -> void:
	global_position = GlobalValues.PlayerSpawnPos

func _process(delta: float) -> void:
	#TODO: Make more robust and add diagonals
	if velocity.y > 0:
		$PlayerSprites.play("WalkDown")
		$PlayerSprites.flip_h = false
	elif velocity.y < 0:
		$PlayerSprites.play("WalkUp")
		$PlayerSprites.flip_h = false
	elif velocity.x > 0:
		$PlayerSprites.play("WalkSideways")
		$PlayerSprites.flip_h = false
	elif velocity.x < 0:
		$PlayerSprites.play("WalkSideways")
		$PlayerSprites.flip_h = true
	else:
		$PlayerSprites.stop()

func _physics_process(delta: float) -> void:
	#Movement code
	var x_direction := Input.get_axis("p_left", "p_right")
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var y_direction := Input.get_axis("p_up", "p_down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#Interaction code goes here
	if Input.is_action_just_pressed("p_interact"):
		print("Nothin' here dumbass")

	move_and_slide()
