extends CharacterBody2D
#movement
var player_speed = 400
var dash_speed = 2.5 * player_speed
var is_dashing = false
#var is_attacking = false
var is_blocking = false
#var is_walking = false
#textury 
#var player : Texture
#var player_block : Texture
#statystyki
#var hp = 100
#var strenght = 1
#var posture = 100
@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.active = true

func _physics_process(_delta):
	
	if Input.is_action_pressed("right_click"):
		animation_tree["parameters/conditions/is_blocking"] = true
		animation_tree["parameters/conditions/is_attacking"] = false
		animation_tree["parameters/conditions/is_idle"] = false
	elif Input.is_action_pressed("left_click"):
		animation_tree["parameters/conditions/is_attacking"] = true
		animation_tree["parameters/conditions/is_blocking"] = false
		animation_tree["parameters/conditions/is_idle"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_blocking"] = false
		animation_tree["parameters/conditions/is_attacking"] = false
	
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if is_dashing:
		velocity = velocity.normalized() * dash_speed
	else:
		velocity = input_direction * player_speed 
		
	
	rotation = get_global_mouse_position().angle_to_point(position)
	move_and_slide()
	
	if Input.is_action_just_pressed("space") and not is_dashing:
		$Dash_timer.start()
		is_dashing = true

func _on_dash_timer_timeout():
	player_speed = 400
	is_dashing = false 
