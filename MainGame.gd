extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var main_deck = []

var player_deck = []
var cpu_deck = []

enum Item {ROCK=1, PAPER=2, SCISSORS=3}


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	pass # Replace with function body.

# warning-ignore:unused_argument
func generate_random_deck(size):
	main_deck = []
	for n in size:
		main_deck.append(randi()%3+1)
	return main_deck
	pass
	
	
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func generate_deck(rock, paper, scissors):
	pass

func shuffel_deck():
	
	pass

func split_into_decks():
	
	pass

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func battle_cards(player_card, cpu_card):
	pass



