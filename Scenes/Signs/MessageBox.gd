extends Node2D

export(String, MULTILINE) var message
export (Vector2) var hide_pos = Vector2(340,0)

export(String, FILE) onready var scene_file_path

func _ready():
	$VBoxContainer/Button.disabled = true
	$VBoxContainer/Message.text = message
	position = hide_pos
	visible = false

	show()


func hide():
	$VBoxContainer/Button.disabled = true

	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", position, hide_pos, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	
	yield(tween, "tween_completed")
	visible = false
	
	if scene_file_path :
		switch_scene()

func show():
	$VBoxContainer/Button.disabled = false
	visible = true
	
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", hide_pos, Vector2(0,0), 1, Tween.TRANS_BOUNCE, Tween.EASE_IN)
	tween.start()

	yield(tween, "tween_completed")
	pass	





func switch_scene():
	print("Switching to scene ")
	print(scene_file_path)
	get_tree().change_scene(scene_file_path)
