class_name Enemic extends CharacterBody2D


const  SPEED = 20
var direction = 1
var canviar = false
@onready var animatedSprite = $AnimatedSprite2D
@onready var timer = $Timer
var dead = false
var attack = false
var killPlayer = false

func _ready():
	pass

func _process(delta):
	
	if attack == true && dead == false:
		animatedSprite.play("Attack")
	elif dead == false :
		animatedSprite.play("Walk")
		position.x += direction * SPEED * delta
		
	


func _on_timer_timeout():
	if canviar:
		canviar = false
		direction = 1
		animatedSprite.flip_h = false
		$KillPlayer/CollisionShape2D.disabled = false
		$DetectionPlayer/CollisionShape2D.disabled = false
		$DetectionPlayer2/CollisionShape2D.disabled = true
		$KillPlayer2/CollisionShape2D.disabled = true
	else:
		canviar = true
		direction = -1
		animatedSprite.flip_h = true
		
		$KillPlayer/CollisionShape2D.disabled = true
		$DetectionPlayer/CollisionShape2D.disabled = true
		$DetectionPlayer2/CollisionShape2D.disabled = false
		$KillPlayer2/CollisionShape2D.disabled = false
		
func _on_kill_area_entered(area):
	if area.is_in_group("Hit"):
		dead = true
		animatedSprite.play("Die")
		killPlayer = false
		
func _on_animated_sprite_2d_animation_finished():
	if animatedSprite.animation == "Die":
		queue_free()
	if animatedSprite.animation == "Attack":
		attack = false
		

func _on_detection_player_area_entered(area):
	
	if area.is_in_group("player"):
		attack = true
		killPlayer = true
		

func _on_kill_player_area_entered(area):
	if area.is_in_group("player"):
		if killPlayer && !dead:
			get_tree().reload_current_scene()
		
	

func _on_detection_player_2_area_entered(area):
	if area.is_in_group("player"):
		attack = true
		killPlayer = true


func _on_kill_player_2_area_entered(area):
		if area.is_in_group("player"):
			if killPlayer && !dead:
				get_tree().reload_current_scene()
		
