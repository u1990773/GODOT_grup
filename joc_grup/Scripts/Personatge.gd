class_name Player extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -310.00

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
var dir = 0
var attacking = false
var defens = false
var slides = false 

func _process(delta):
	if !defens and !slides:
		if Input.is_action_just_pressed("attack"):
			attack()

	if !attacking and !slides:
		if Input.is_action_just_pressed("defense"):
			defense()

	if !attacking and !defens:
		if Input.is_action_just_pressed("slide"):
			slide()
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Input direction
	var direction = Input.get_axis("move_left", "move_right")
	
	dir = direction
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if !attacking and !defens and !slides:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("Idel")
			else:
				animated_sprite.play("walk")
				
				
		else:
			animated_sprite.play("jump")
	 
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func attack():
	attacking = true
	animated_sprite.play("atacar")
	
	if animated_sprite.flip_h == false:
		$AtackkArea/CollisionShape2D.disabled = false
	elif animated_sprite.flip_h == true:
		$AtackkArea2/CollisionShape2D2.disabled = false

func defense():
	defens = true
	animated_sprite.play("defensar")
	
	if animated_sprite.flip_h == false:
		$DefensArea/CollisionShape2D.disabled = false
	elif animated_sprite.flip_h == true:
		$DefensArea2/CollisionShape2D2.disabled = false


func slide():
	slides = true
	animated_sprite.play("slide")
	
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "atacar":
		$AtackkArea/CollisionShape2D.disabled = true
		$AtackkArea2/CollisionShape2D2.disabled = true
		attacking = false
		
		
	if animated_sprite.animation == "defensar":
		$DefensArea/CollisionShape2D.disabled = true
		$DefensArea2/CollisionShape2D2.disabled = true
		defens = false

	if animated_sprite.animation == "slide":
		slides = false
	
	
