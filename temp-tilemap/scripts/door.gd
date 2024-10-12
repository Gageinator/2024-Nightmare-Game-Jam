extends Area2D

@export var targetScene:String = "node_2d.tscn"
@export var targetPosition: Vector2 = Vector2(0, 0)

func touchingDoor(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		GlobalValues.PlayerSpawnPos = targetPosition
		get_tree().change_scene_to_file("res://scenes/" + targetScene)
		pass
	pass # Replace with function body.
