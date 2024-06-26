extends RigidBody2D

var time = randf_range(1, 2)

var moving: bool = false
var target_position: Vector2
var direction: float
var speed = 100.0
var frames
var base_rotation

func change_sprite_animation(animation_name: String):
	$AnimatedSprite2D.play(animation_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	#$explostion.wait_time = min(randf_range((2 - rotation) *0.75, (2 - rotation) * 1.25), 1.5) 
	#$explostion.wait_time = randf_range(0.5 , 3 - rotation)
	#print($explostion.wait_time)
	base_rotation = $AnimatedSprite2D.rotation
	speed =  randf_range(1, 3)
	start_movement()
	$explostion.start()
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play("new_animation")
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func compute_angle(vec1: Vector2, vec2: Vector2):
	return acos(vec1.dot(vec2) / (vec1.dot(vec1) * vec2.dot(vec2))) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#target_position = Vector2(-500, 00)
	if moving:
		# Move the animated sprite towards the target position
		# $AnimatedSprite2D.position += direction * speed * delta
		#var angle = compute_angle($AnimatedSprite2D.position, target_position)
		# Rotate the sprite to face the movement direction
		#$AnimatedSprite2D.rotation = (angle + PI / 2) / PI * 180

		# var direction = target_position.rotation  + PI / 2

		## Set the mob's position to a random location.
		## Add some randomness to the direction.
		#direction += randf_range(-PI / 4, PI / 4)
	#
		## Choose the velocity for the mob.
		var velocity = Vector2(100, 0) * speed
		var velocity_rotated = velocity.rotated(direction)
		$AnimatedSprite2D.rotation = direction + PI/2
		$AnimatedSprite2D.position = $AnimatedSprite2D.position + velocity_rotated* speed * delta
		frames -= 1
		if frames == 0:
			moving = false
			$AnimatedSprite2D.position = target_position

func start_movement():
	moving = true
	
func _on_explostion_timeout():
	change_sprite_animation("explosion")
	moving = false
	# $AnimatedSprite2D.linear_velocity =  Vector2(0, 0)
	#speed = 0.0

	$delete.start()
	# change_sprite_animation("")	


func _on_delete_timeout():
	change_sprite_animation("")	
	queue_free()
