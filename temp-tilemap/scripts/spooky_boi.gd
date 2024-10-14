extends CharacterBody2D


@export var SPEED: float = 200.0
var player: CharacterBody2D
#default target, will get overwritten in setup
var target: Vector2 = Vector2(100, 100)

var cries: Array = ["Coward Stop Running", "Pull the Trigger You Bastard", "I Am You", "Die Just Die",
"Says something very not nice lol", "She Was Just A Child", "You Always Run", "You Can't Live Without Me",
"You Did This to Yourself", "You Need Me"]

@onready var navAgent: NavigationAgent2D = $NavigationAgent2D

#Called when the node enters the scene tree for the first time
func _ready() -> void:
	navAgent.path_desired_distance = 4
	navAgent.target_desired_distance = 4
	
	#Replace with actual character node
	player = get_tree().root.get_node("sroot/Bingus")
	$CryPlayer.play()
	
	setup.call_deferred()

#This was in the Godot docs tutorial, don't touch it
func setup():
	await get_tree().physics_frame
	
	setTarget(player.global_position)
	
#Set enemy target position
func setTarget(movementTarget: Vector2):
	navAgent.target_position = movementTarget
	
#Called every visual frame
func _process(delta: float) -> void:
	var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D
	#If audio has stopped playing, start it over
	if audioStream.playing == false:
		audioStream.play(0)
		audioStream.pitch_scale = randf_range(0.9, 1.1)
		
	if player.global_position.y >= global_position.y:
		player.z_index = 1
	else:
		player.z_index = 0
		
	#Rotation
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			$SpookySprites.play("move_sideways")
			$SpookySprites.flip_h = false
		elif velocity.x < 0:
			$SpookySprites.play("move_sideways")
			$SpookySprites.flip_h = true
	elif abs(velocity.x) < abs(velocity.y):
		if velocity.y > 0:
			$SpookySprites.play("move_down")
		elif velocity.y < 0:
			$SpookySprites.play("move_up")
			
		if $SpookySprites.frame == 0:
			$SpookySprites.flip_h = false
		else:
			$SpookySprites.flip_h = true
		

#Called every physics tick
func _physics_process(delta: float) -> void:
	#If navigation has finished
	if navAgent.is_navigation_finished():
		setTarget(player.global_position)
		return
	
	#Check if target is reachable
	if navAgent.is_target_reachable():
		var currPos: Vector2 = global_position
		var nextPathPos: Vector2 = navAgent.get_next_path_position()
	
		velocity = currPos.direction_to(nextPathPos) * SPEED
		move_and_slide()
	else: #If target is not reachable
		setTarget(player.global_position)
	
#Update target position on timer callback
func retarget() -> void:
	setTarget(player.global_position)

#Timer callback for monster cries
func doCry() -> void:
	playRandomCry()
		
#Plays a random monster cry from an array
func playRandomCry():
	if not $CryPlayer.get_stream_playback().is_stream_playing(0):
		var index = randi_range(0, cries.size() - 1)
		$CryPlayer.get_stream_playback().play_stream(load("res://assets/" + cries[index] + ".wav"))
		#Randomize the wait time
		$CryTimer.wait_time = randf_range(10, 20)

func touchPlayer(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		killBingus.call_deferred()
		
func killBingus():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
