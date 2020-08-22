extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#TODO: Cards
export(Resource) var paper_tscn

var main_deck = []

var player_deck = []
var cpu_deck = []

enum {ROCK=1, PAPER=2, SCISSORS=3}

enum {WIN=1, LOSE=2, DRAW=3}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()

	print(battle_cards(ROCK,ROCK))

	pass # Replace with function body.


func generate_random_deck(size):
	main_deck = []
	for n in size:
		main_deck.append(randi()%3+1)
	return main_deck
	
	
# generates array with number of elements set as parameter
# Example: (2 rocks, 3 papers, o scissors) results in [1 ,1, 2, 2, 2]
func generate_deck(nrock, paper, scissors):
	main_deck = []
	for x in nrock:
		main_deck.append(ROCK)
	for x in paper:
		main_deck.append(PAPER)
	for x in scissors:
		main_deck.append(SCISSORS)
		
			
	return main_deck


func shuffle_deck(deck):
	deck.shuffle()


# First half into player deck, second half into CPU. Clears base deck
func split_into_decks():
	player_deck = main_deck.slice(0,(len(main_deck)/2)-1)
	cpu_deck = main_deck.slice(len(main_deck)/2, len(main_deck))
	main_deck=[]
		
	pass

#Returns WIN if player card wins, LOSE if cpu wins
func battle_cards(player_card, cpu_card):
	if player_card == cpu_card:
		return DRAW
	if player_card-cpu_card ==1 or player_card-cpu_card ==-2:
		return WIN 
	
	return LOSE




