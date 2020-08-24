extends Area2D

onready var n_main_game = get_parent().get_parent()



func _ready():
	#Check main and enable self
	if n_main_game.can_peak:
		#enable
		$Label.visible = true
	else:
		$Label.visible = false
	
	pass # Replace with function body.



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.is_pressed():
			button_pressed()
	pass # Replace with function body.

func button_pressed():

	if not n_main_game.peak():
		_ready()
