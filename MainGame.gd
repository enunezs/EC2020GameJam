extends Node2D



export(Resource) var basic_card

# DECK PROPERTIES
export(int) var deck_rock
export(int) var deck_paper
export(int) var deck_scissors

# coordinates / nodes for cards

onready var n_player_cards = $PlayerCards
onready var n_player_active_card = $PlayerActiveCard

onready var n_cpu_cards = $CPUCards
onready var n_cpu_active_card = $CPUActiveCard

onready var n_start_cards = $StartCards
onready var n_discard_pile = $DiscardCards

onready var n_ui_canvas = $UI



var main_deck = []
var player_deck = []
var cpu_deck = []
var discard_pile = []

enum {ROCK=1, PAPER=2, SCISSORS=3}
enum {WIN=1, LOSE=2, DRAW=3}
enum {PLAYER=1, CPU=2}
enum {UP, DOWN}

var cpu_card
var player_card
var is_playing =false

var can_peak =false

var cpu_score = 0
var player_score = 0

export var card_spacing = 8
export var card_length = 32

# messages

export(String, MULTILINE) var start_message
export(String, MULTILINE) var ending_message

export(Resource) var win_message
export(Resource) var lose_message
export(Resource) var base_message


export(String, FILE) onready var next_scene


# Called when the node enters the scene tree for the first time.

func _ready():
	$MessageBox/VBoxContainer/Message.text = start_message
	$AudioStreamPlayer.play(0)

func ready():
	
	#General setup, maybe move later
	randomize()
	basic_card = load("res://Cards/CardBase.tscn")

	#Start new game
	game_setup()
	
	#game_setup()
	play_game()
	#yield(get_tree().create_timer(2.0), "timeout")

	
	#show_start_message()
	
###########################
### CORE GAME FUNCTIONS ###
###########################

#setups all variables
func game_setup():

	is_playing = false

	#Build deck from intial settings and show at center
	generate_deck(deck_rock, deck_paper, deck_scissors)
	#yield(set_deck_position(main_deck,n_start_cards),"completed")
	yield(get_tree().create_timer(0.7), "timeout")


	#TODO: Appear from out of screen FACEDOWN

	#Display the deck
	yield(display_deck(),"completed")
	yield(get_tree().create_timer(0.5), "timeout")

	#TODO: Update counter!
	n_ui_canvas.update_counter(count_cards())


	#Flip the cards
	yield(flip_cards(main_deck ,DOWN), "completed")

	#Cards back to center ("shuffle")
	#yield(set_deck_position(main_deck,n_start_cards),"completed")
	#Shuffle deck and give cards
	shuffle_deck(main_deck)
	split_into_decks()

	#Arrange
	yield(arrange_cards(),"completed")
	yield(flip_cards(player_deck ,UP), "completed")


	
	discard_pile = []
	
	#print("Start deck: ")
	#print(main_deck)

	cpu_card = null
	player_card = null


	cpu_score = 0
	player_score = 0

	n_ui_canvas.clear_score()

	for card in player_deck:
		card.clickable = true
	#return 
	#start_anim()
	print("Setup done")

	CPU_pick()
	can_peak =true
	$UI/PeakButton._ready()
	


func play_game():

	is_playing = false

	yield(arrange_cards(),"completed")


	if (player_card == null ):
		#setup board / first play

		pass

	else:
		#Fight
		cpu_card.face_up()
		yield(get_tree().create_timer(0.5), "timeout")


		var result = battle_cards(player_card, cpu_card)
		
			
		#Discard cards
		if result == WIN:
			discard_card(cpu_card)
			yield(player_card.move_to(n_start_cards.position),"completed")
			discard_card(player_card)
			player_score = player_score + 1 
			#TODO: Sound?
		if result == LOSE:
			discard_card(player_card)
			yield(cpu_card.move_to(n_start_cards.position),"completed")
			discard_card(cpu_card)
			cpu_score = cpu_score + 1
			#TODO: Sound?
		if result == DRAW:
			yield(get_tree().create_timer(1), "timeout")
			discard_card(player_card)
			discard_card(cpu_card)

		#update score
		n_ui_canvas.update_score(player_score, cpu_score)

		for card in player_deck:
			card.clickable = true
		
		

		if len(cpu_deck)>0:
			CPU_pick()
		else:
			game_over()
		

	#Start the game proper
	is_playing = true

	#First CPU pick
	#CPU picks card (and moves to center)

	


	#From this point on, the whole system is event driven
	#Wait for user input, compare cards, update scores, CPU pick, repeat
	
func show_start_message():
	
	var current_instance = base_message.instance()
	add_child(current_instance)
	#current_instance.connect( ,self,game_setup())
	current_instance.message = start_message
	current_instance.show()

func game_over():
	
	#instance message
	if cpu_score > player_score:
		#LOSE
		var current_instance = lose_message.instance()
		add_child(current_instance)
		current_instance.show()
		
	elif cpu_score < player_score:
		#WIN
		var current_instance = win_message.instance()
		add_child(current_instance)
		current_instance.show()
		current_instance.scene_file_path = next_scene
	else:
		#DRAW
		
		get_tree().reload_current_scene()
	#Tell the manager
	pass



func CPU_pick():
	#Just pick at random
	var index = randi() % cpu_deck.size()
	cpu_card = cpu_deck[index]
	cpu_deck.remove(index)
	 
	
	yield(cpu_card.move_to(n_cpu_active_card.position),"completed")
	#cpu_card.face_up()



func Player_pick(card):
	if not is_playing:
		return
	player_deck.erase(card)
	player_card = card
	card.move_to(n_player_active_card.position)
	play_game()

func peak():
	if not is_playing or not cpu_card:
		return true
	elif not can_peak:
		return false
	cpu_card.face_up()
	can_peak =false
	
	pass


func card_click(card):

	if not is_playing:
		return false
	


	if card in player_deck:
		#select card
		Player_pick(card)
		return true
	
	


######################
### CARD FUNCTIONS ###
######################


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
	current_instance.position = n_start_cards.position
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
	
	var p_type = player_card.card_type
	var cpu_type = cpu_card.card_type


	if p_type == cpu_type:
		print("DRAW")
		return DRAW
	
	if p_type-cpu_type ==1 or p_type-cpu_type ==-2:
		print("WIN")
		return WIN
		
	
	print("LOSE")
	return LOSE


#returns list!
func count_cards():
	var amount = [0,0,0]
	for card in main_deck:
		amount[card.card_type-1] = 1 + amount[card.card_type-1]

	return amount

#####################################
### CARD ANIMATIONS & ARRANGEMENT ###
#####################################

func display_deck():

	var spacing = 8
	var card_length = 48/2

	var length = (len(main_deck)-1)*(spacing+card_length)
	var start = n_start_cards.position
	start.x = start.x - length/2

	#player deck on bottom
	for n_card in len(main_deck):
		var pos = Vector2(start.x + n_card*(card_length+spacing), start.y)
		yield(get_tree().create_timer(0.1), "timeout")
		main_deck[n_card].move_to(pos)
	
	yield(get_tree().create_timer(1.0), "timeout")


func arrange_cards():

#arrange along a line centered at node player_cards
	#n_player_cards


	var length = (len(player_deck)-1)*(card_spacing+card_length)
	var start = n_player_cards.position
	start.x = start.x - length/2


	#player deck on bottom
	for n_card in len(player_deck):
		var pos = Vector2(start.x + n_card*(card_length+card_spacing), start.y)
		yield(get_tree().create_timer(0.1), "timeout")
		player_deck[n_card].move_to(pos)

	length = (len(cpu_deck)-1)*(card_spacing+card_length)
	start = n_cpu_cards.position
	start.x = start.x - length/2

	#rival deck on top
	#yield(get_tree().create_timer(1.0), "timeout")
	for n_card in len(cpu_deck):
		var pos = Vector2(start.x + n_card*(card_length+card_spacing), start.y)
		yield(get_tree().create_timer(0.1), "timeout")
		cpu_deck[n_card].move_to(pos)
	
	yield(get_tree().create_timer(1.0), "timeout")

	#Discard pile on right




func flip_cards(deck ,dir):

	for n_card in deck:
		if dir == UP:
			n_card.face_up()
		if dir == DOWN:
			n_card.face_down()
		yield(get_tree().create_timer(0.15), "timeout")


func discard_card(card):

	#add to discard pile and move

	discard_pile.append(card)
	#card.move_to(n_discard_pile.position)
	card.float_to(n_discard_pile.position)
	card.z_index=len(discard_pile)

	pass
