extends Area2D

export(String, FILE) onready var scene_file_path



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.is_pressed():
			button_pressed()
	pass # Replace with function body.


func button_pressed():

	print("Switching to scene ")
	print(scene_file_path)
	get_tree().change_scene(scene_file_path)
