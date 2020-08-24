extends Button


export(String, FILE) onready var scene_file_path

func _on_ButtonPlay_pressed():
	print("Switching to scene ")
	print(scene_file_path)
	get_tree().change_scene(scene_file_path)
