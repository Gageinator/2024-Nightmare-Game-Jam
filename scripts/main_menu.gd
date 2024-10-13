extends MarginContainer

#This code is horrible but there are only two buttons so it's fine

var buttonFocused = 0

func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p_down") or Input.is_action_just_pressed("p_up"):
		if buttonFocused == 0:
			$VBoxContainer/QuitButton.grab_focus()
			buttonFocused = 1
		else:
			$VBoxContainer/StartButton.grab_focus()
			buttonFocused = 0
			
	if Input.is_action_just_pressed("p_interact"):
		if buttonFocused == 0:
			startGame.call_deferred()
		else:
			quitGame.call_deferred()
	
	pass

func startGamePressed() -> void:
	startGame.call_deferred()
	pass 

func startGame():
	GlobalValues.PlayerSpawnPos = Vector2(0, -2675)
	#get_tree().change_scene_to_file("res://scenes/hallway_third_version_(long_boi_1st_chase).tscn")
	get_tree().change_scene_to_file("res://scenes/bathroom_maze_main.tscn")

func quitGamePressed() -> void:
	quitGame.call_deferred()
	
func quitGame():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
