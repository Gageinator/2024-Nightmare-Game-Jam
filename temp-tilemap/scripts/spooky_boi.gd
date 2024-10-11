extends CharacterBody2D


@export var SPEED: float = 200.0
var player: CharacterBody2D
#default target, will get overwritten in setup
var target: Vector2 = Vector2(100, 100)

@onready var navAgent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	navAgent.path_desired_distance = 4
	navAgent.target_desired_distance = 4
	
	#Replace with actual character node
	player = get_tree().root.get_node("sroot/Bingus")
	
	setup.call_deferred()

#This was in the Godot docs tutorial, don't touch it
func setup():
	await get_tree().physics_frame
	
	setTarget(player.global_position)
	
#Set enemy target position
func setTarget(movementTarget: Vector2):
	navAgent.target_position = movementTarget
	
func _process(delta: float) -> void:
	var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D
	#If audio has stopped playing, start it over
	if audioStream.playing == false:
		audioStream.play(0)
	pass

func _physics_process(delta: float) -> void:
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
	
