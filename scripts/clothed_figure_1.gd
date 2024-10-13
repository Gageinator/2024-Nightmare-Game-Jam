extends Area2D

var collision = false




	

func _physics_process(delta: float) -> void:
	if (collision == true):
		#print("inside")
		pass
		
func _onInput():
	if (Input.is_action_pressed("p_interact")):
		if collision == true:
		
			print("aaaaaaaaaaaaa")


func _on_body_entered(body: Node2D) -> void:
	collision = true
	if (body.is_in_group("player_group")):
			print("Collision detected")


func _on_body_exited(body: Node2D) -> void:
	print("player exited")
	collision = false
