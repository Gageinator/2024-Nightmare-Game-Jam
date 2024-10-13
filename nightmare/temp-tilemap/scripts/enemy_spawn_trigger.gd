extends Area2D

@export var spawn_pos: Vector2 = Vector2(0,0)
@export var enemy_speed: float = 315
@export var activeNumber: int = 0

#Enemy scene
var spooky_scene:PackedScene = preload("res://scenes/spooky_boi.tscn")

static var sceneRoot: Node2D

func _ready() -> void:
	sceneRoot = get_tree().root.get_node("sroot")

#Spawn the enemy when trigger is touched
func doSpawn(body: Node2D) -> void:
	if GlobalValues.EventFlagNum == activeNumber:
		if body.is_in_group("player_group"):
			doSpawn2.call_deferred()
		
#Spawns the enemy at the end of the physics tick
func doSpawn2():
	await get_tree().physics_frame
	
	var enemy_instance = spooky_scene.instantiate()
	#Add enemy to scene root
	sceneRoot.add_child(enemy_instance)
	#Set enemy to spawn pos
	enemy_instance.global_position = spawn_pos
	#Set the enemy's speed
	enemy_instance.SPEED = enemy_speed
	queue_free()
	
