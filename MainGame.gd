extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#TODO: Cards
export(Resource) var basic_card

# DECK PROPERTIES
export(int) var deck_rock
export(int) var deck_paper
export(int) var deck_scissors

# coordinates / nodes for cards

onready var n_player_cards = $PlayerCards
onready var n_cpu_cards = $CPUCards
onready var n_start_cards = $StartCards



var main_deck = []
var player_deck = []
var cpu_deck = []

var discard_pile

enum {ROCK=1, PAPER=2, SCISSORS=3}

enum {WIN=1, LOSE=2, DRAW=3}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#General setup, maybe move later
	randomize()
	basic_card = load("res://Cards/CardBase.tscn")

	#Start new game
	start_game()

	pass # Replace with function body.


func start_game():


	#Generate cards from intial settings and split
	generate_deck(deck_rock, deck_paper, deck_scissors)
	
	shuffle_deck(main_deck)
	split_into_decks()
	print("Start deck: ")
	print(main_deck)


	print("Player deck: ")
	print(player_deck)

	print("CPU deck: ")
	print(cpu_deck)


	#Arrange cards

	#TODO: CARDS ON START PILE

	arrange_cards()

	pass


func generate_random_deck(size):
	main_deck = []
	if size %2>0:
		size = size +1
	for n in size:
		var new_card = new_card(randi()%3+1)
		main_deck.append(new_card)
		#new_card.get_parent().remove_child(new_card)
		#n_start_cards.add_child(new_card)
		
	return main_deck
	
	
# generates array with number of elements set as parameter
# Example: (2 rocks, 3 papers, o scissors) results in [1 ,1, 2, 2, 2]
func generate_deck(nrock, paper, scissors):
	main_deck = []
	for x in nrock:
		var new_card = new_card(ROCK)
		main_deck.append(new_card)
		#new_card.get_parent().remove_child(new_card)
		#n_start_cards.add_child(new_card)	
	for x in paper:
		var new_card = new_card(PAPER)
		main_deck.append(new_card)
		#new_card.get_parent().remove_child(new_card)
		#n_start_cards.add_child(new_card)	
	for x in scissors:
		var new_card = new_card(SCISSORS)
		main_deck.append(new_card)
		#new_card.get_parent().remove_child(new_card)
		#n_start_cards.add_child(new_card)	
	
	if(len(main_deck)%2>0):
		var new_card = new_card(ROCK)
		main_deck.append(new_card)
		#new_card.get_parent().remove_child(new_card)
		#n_start_cards.add_child(new_card)	

			
	return main_deck


func new_card(type):

	#instance a card and intialize type
	#Make instance
	var current_instance = basic_card.instance()
	add_child(current_instance)
	current_instance.set_cardtype(type)
	return current_instance

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




func arrange_cards():

#arrange along a line centered at node player_cards
	#n_player_cards
	var spacing = 16
	var card_length = 64

	var length = (len(player_deck)-1)*(spacing+card_length)
	var start = n_player_cards.position
	start.x = start.x - length/2



	for n_card in len(player_deck):
		var pos = Vector2(start.x + n_card*(card_length+spacing), start.y)
		print(pos)
		player_deck[n_card].move_to(pos)

	length = (len(cpu_deck)-1)*(spacing+card_length)
	start = n_cpu_cards.position
	start.x = start.x - length/2

	for n_card in len(cpu_deck):
		var pos = Vector2(start.x + n_card*(card_length+spacing), start.y)
		print(pos)
		cpu_deck[n_card].move_to(pos)



	pass

