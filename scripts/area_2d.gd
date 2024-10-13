extends Area2D

var spooky_scene:PackedScene = preload("res://scenes/spooky_boi.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		var enemy_instance = spooky_scene.instantiate()
		get_tree().root.get_node("sroot").add_child(enemy_instance)
		enemy_instance.global_position = Vector2(0, -2675)
		enemy_instance.SPEED = 315
		queue_free()
