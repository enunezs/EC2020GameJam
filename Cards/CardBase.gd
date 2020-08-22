extends Area2D

var index

#export(int, "Rock", "Paper", "Scissors") var card_type 

enum NamedEnum {ROCK = 1, PAPER =2, SCISSORS = 3}
export(NamedEnum) var card_type = 1


#export(Texture) onready var rock_texture
#export(Texture) onready var paper_texture
#export(Texture) onready var scissors_texture

onready var rock_texture
onready var paper_texture
onready var scissors_texture



onready var n_sprite = $Sprite

func _ready():
	#set_cardtype(card_type)
	rock_texture = "res://Cards/Sprites/Card_Rock-1.png.png"

	paper_texture = "res://Cards/Sprites/Card_Paper-1.png.png"
	scissors_texture = "res://Cards/Sprites/Card_Scissors-1.png"
	pass
	
func set_cardtype(new_val):
	card_type = new_val

	#print(rock_texture)

	if card_type == 1:
		n_sprite.set_texture(load(rock_texture))
	if card_type == 2:
		n_sprite.set_texture(load(paper_texture))
	if card_type == 3:
		n_sprite.set_texture(load(scissors_texture))

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


func move_to(target):
	#var tween = get_node("Tween")
	#tween.interpolate_property($Node2D, "position", position, target, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#tween.start()
	position=target

