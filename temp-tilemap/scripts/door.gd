extends Area2D

##Scene file to be transitioned to
@export var targetScene:String = "node_2d.tscn"
##The player's coordinates in the new scene
@export var targetPosition: Vector2 = Vector2(0, 0)
##The event flags in which the door appears
@export var activeNumbers: Array = [0]

var touching: bool = false

#func _physics_process(delta: float) -> void:
#	if Input.is_action_just_pressed("p_interact"):
#		if touching: 
#			for i in range(activeNumbers.size()):
#				if activeNumbers[i] == GlobalValues.EventFlagNum:
#					changeScene.call_deferred()
#			
#	pass

#func touchingDoor(body: Node2D) -> void:
#	#print("touch")
#	if body.is_in_group("player_group"):
#		touching = true
		
		
func changeScene():
	GlobalValues.PlayerSpawnPos = targetPosition
	targetScene = "res://scenes/" + targetScene
	get_tree().change_scene_to_file(targetScene)

#func stopTouchingDoor(body: Node2D) -> void:
#	touching = false
