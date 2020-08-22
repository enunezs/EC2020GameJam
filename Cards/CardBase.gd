extends Area2D

var index

export(int, "Rock", "Paper", "Scissors") var card_type 

export(Texture) onready var rock_texture
export(Texture) onready var paper_texture
export(Texture) onready var scissors_texture

onready var n_sprite = $Sprite

func _ready():
	
	pass
	
func set_cardtype(new_val):
	card_type = new_val

	print(rock_texture)

	if card_type == 1:
		n_sprite.set_texture(rock_texture)
	if card_type == 2:
		n_sprite.set_texture(paper_texture)
	if card_type == 3:
		n_sprite.set_texture(scissors_texture)

	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	#tell parent
	print("CLICK")
	pass
