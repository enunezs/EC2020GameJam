extends Area2D

var index

#export(int, "Rock", "Paper", "Scissors") var card_type 

enum NamedEnum {ROCK = 1, PAPER =2, SCISSORS = 3}
export(NamedEnum) var card_type = 1

export(Texture) onready var back_texture

export(Texture) onready var rock_texture
export(Texture) onready var paper_texture
export(Texture) onready var scissors_texture

var facing_up = true #Showing type by default

var clickable = false

#onready var rock_texture
#onready var paper_texture
#onready var scissors_texture



onready var n_sprite = $Sprite

func _ready():
	#set_cardtype(card_type)
	#rock_texture = "res://Cards/Sprites/Card_Rock-1.png.png"
	#paper_texture = "res://Cards/Sprites/Card_Paper-1.png.png"
	#scissors_texture = "res://Cards/Sprites/Card_Scissors-1.png"
	pass
	
func set_cardtype(new_val):
	card_type = new_val

	#print(rock_texture)

	if card_type == 1:
		#n_sprite.set_texture(load(rock_texture))
		n_sprite.set_texture(rock_texture)
	if card_type == 2:
		#n_sprite.set_texture(load(paper_texture))
		n_sprite.set_texture(paper_texture)
	if card_type == 3:
		#n_sprite.set_texture(load(scissors_texture))
		n_sprite.set_texture(scissors_texture)
		

	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()



func on_click():
	#tell parent
	#print("CLICK")
	if clickable:
		clickable = get_parent().card_click(self)





func move_to(target):
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	
	tween.start()
	
	yield(tween, "tween_completed")
	#position=target

func float_to(target):
	#var tween = get_node("Tween")
	#tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$AnimationPlayer.play("FloatUp")
	yield( get_node("AnimationPlayer"), "animation_finished" )
	
	
	var pos_error = 25
	var angle_error = 20	
	#randi() % (MAX - MIN) + MIN

	position = target + Vector2(randi() % (2*pos_error) - pos_error, randi() % (2*pos_error) - pos_error)
	
	rotation_degrees = randi() % (2*angle_error) - angle_error
	$AnimationPlayer.play("FloatDown")

	#tween.start()
	
	#yield(tween, "tween_completed")
	#position=target


func face_up():
	facing_up = true
	$AnimationPlayer.play("Flip")
	#flip_texture()

	return

func face_down():
	facing_up = false
	$AnimationPlayer.play("Flip")
	#flip_texture()
	return

func flip_texture():
	if facing_up:
		set_cardtype(card_type)
	else:
		n_sprite.set_texture(back_texture)		
	pass

#TODO ON HOVER



func _on_CardBase_mouse_entered():
	if clickable:
		#$AnimationPlayer.play("Hover")
		var tween = get_node("ScaleTween")
		tween.interpolate_property(self, "scale", scale, Vector2(1.2,1.2), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	
		#yield(tween, "tween_completed")
	pass # Replace with function body.


func _on_CardBase_mouse_exited():
	
	var tween = get_node("ScaleTween")
	tween.interpolate_property(self, "scale", scale, Vector2(1,1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	#if clickable:
	
	#$AnimationPlayer.play("Un-hover")
	#else:
	#	$Sprite.scale = Vector2(1,1)
	#	$Sprite.position = Vector2(0,0) 

	pass # Replace with function body.
