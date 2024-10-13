extends Area2D

#Don't stack these on top of each other, that will cause issues

@export var dialogueResource: DialogueResource
@export var dialogueStart: String = "start"

##The event flags in which the actionable appears
@export var activeNumbers: Array = [0]
##Value to change the event flag to after interaction takes place, negative values are ignored
@export var eventChange: int = -1
##If false the object will be removed after interacting
@export var repeatable: bool = true

func action() -> void:
	for i in range(activeNumbers.size()):
		if activeNumbers[i] == GlobalValues.EventFlagNum:
			DialogueManager.show_dialogue_balloon(dialogueResource, dialogueStart)
			
			if eventChange > -1:
				GlobalValues.EventFlagNum = eventChange
				
			if not repeatable:
				queue_free()
			break
