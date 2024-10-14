extends MarginContainer


func _ready() -> void:
	$VBoxContainer/Button.grab_focus()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p_interact"):
		changeToTitle.call_deferred()

func retryPressed() -> void:
	changeToTitle.call_deferred()

func changeToTitle():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
