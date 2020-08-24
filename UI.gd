extends CanvasLayer


onready var n_score_text = $ScoreBox/HBoxContainer/Score
onready var n_rock_text = $CounterBox/VBoxContainer/RockContainer/RockCounter
onready var n_paper_text = $CounterBox/VBoxContainer/PaperContainer/PaperCounter
onready var n_scissors_text = $CounterBox/VBoxContainer/ScissorsContainer/ScissorsCounter


func _ready():
	clear_score()
	clear_counter()
	

func update_score(player_score, cpu_score):
	n_score_text.text = str(player_score) + "-" + str(cpu_score)


func clear_score():
	n_score_text.text = ""


#TODO ANIMATE going up!
func update_counter(n_list):
	n_rock_text.text = "x" + str(n_list[0])
	n_paper_text.text = "x" + str(n_list[1])
	n_scissors_text.text = "x" + str(n_list[2])

func clear_counter():
	n_rock_text.text = ""
	n_paper_text.text = ""
	n_scissors_text.text = ""
