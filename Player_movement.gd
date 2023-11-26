extends CharacterBody2D

var player_speed = 400
var dash_speed = 2.5 * player_speed
var is_dashing = false
var dash_duration = 0.2  # czas trwania dasha w sekundach
var dash_timer = 0.0

var player : Texture
var player_block : Texture


func _process(delta):
	if Input.is_action_pressed("right_click"):
		$player_block.visible = true  # Aktywuj Sprite gracza w bloku
		$player.visible = false  # Ukryj Sprite gracza bazowego
	else:
		$player_block.visible = false  # Ukryj Sprite gracza w bloku
		$player.visible = true  # Aktywuj Sprite gracza bazowego
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			player_speed = 400  # przywróć normalną prędkość gracza
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if is_dashing:
		velocity = velocity.normalized() * dash_speed
	else:
		velocity = input_direction * player_speed
	
	rotation = get_global_mouse_position().angle_to_point(position)
	move_and_slide()
	
	if Input.is_action_just_pressed("space") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration
		player_speed = dash_speed  # ustaw prędkość gracza na prędkość dasha
