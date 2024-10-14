extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.NumWrongDirTaken += 1
	
	if GlobalValues.NumWrongDirTaken >= 4:
		GlobalValues.EventFlagNum = 666
