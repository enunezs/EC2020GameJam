extends CanvasLayer


onready var n_score_text = $ScoreBox/HBoxContainer/Score
onready var n_rock_text = $CounterBox/HBoxContainer/RockCounter
onready var n_paper_text = $CounterBox/HBoxContainer/PaperCounter
onready var n_scissors_text = $CounterBox/HBoxContainer/ScissorsCounter


func _ready():
	clear_score()
	clear_counter()
	

func update_score(player_score, cpu_score):
	n_score_text.text = str(player_score) + "-" + str(cpu_score)


func clear_score():
	n_score_text.text = ""


#TODO ANIMATE going up!
func update_counter(n_list):
	n_rock_text.text = "R " + str(n_list[0])
	n_paper_text.text = "P " + str(n_list[1])
	n_scissors_text.text = "S " + str(n_list[2])

func clear_counter():
	n_rock_text.text = ""
	n_paper_text.text = ""
	n_scissors_text.text = ""
