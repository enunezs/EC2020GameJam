extends CanvasLayer


onready var n_text = $ScoreBox/HBoxContainer/Score


func _ready():
	clear_score()
	

func update_score(player_score, cpu_score):
	n_text.text = str(player_score) + "-" + str(cpu_score)


func clear_score():
	n_text.text = ""
	pass

