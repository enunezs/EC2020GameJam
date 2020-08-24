extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, MULTILINE) var message

export (Vector2) var hide_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.disabled = false
	$VBoxContainer/Message.text = message
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hide():
	$VBoxContainer/Button.disabled = true
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", position, hide_pos, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	
	tween.start()
	#n_audio_slide.play(0)

	
	yield(tween, "tween_completed")
	visible = false
	pass
