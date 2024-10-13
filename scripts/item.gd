extends Area2D

##Which flag should spawn the item
@export var activeFlag:int = 0
##Sets the value to change the event flag to after the item is collected
@export var flagPostCollect: int = 0

var touching: bool = false

func _init() -> void:
	if GlobalValues.EventFlagNum != activeFlag:
		queue_free.call_deferred()
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p_interact"):
		if touching:
			collect()
			

func itemTouched(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		touching = true

func collect():
	GlobalValues.EventFlagNum = flagPostCollect
	queue_free()

func stopTouchingItem(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		touching = false
