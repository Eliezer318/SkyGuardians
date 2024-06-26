extends Node

@export var enemy_rocket_scene: PackedScene
#@export var scenes: Array[PackedScene]

var scenes_array: Array = []

# Function to add an instance to the array
func add_scene_instance(scene_instance: Node):
	scenes_array.append(scene_instance)

# Function to get all scene instances
func get_scene_instances() -> Array:
	return scenes_array


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func game_over():
	$EnemyRocketTimer.stop()

func new_game():
	$StartTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func generate_points(path_follow_1 : PathFollow2D, path_follow_2 : PathFollow2D, animated_sprite):
	## Set offsets to generate random points along the path
	#var path_1 = $EnemyRocketPath
	#var path_2 = $target
	#
	#var length_1 = path_1.curve.get_baked_length()
	#var length_2 = path_2.curve.get_baked_length()
#
	#path_follow_1.h_offset = randf() * length_1
	#path_follow_2.h_offset = randf() * length_2
	#
	##path_follow_1.v_offset = randf() * length_1
	##path_follow_2.v_offset = randf() * length_2
#
	## Set the initial position of the animated sprite to the first point
	#animated_sprite.global_position = path_follow_1.global_position
#
	## Set thget position to the second point
	#animated_sprite.target_position = path_follow_2.global_position
	#
	#path_follow_1.progress_ratio =  PI / 2 
	#var velocity = Vector2(100, 0) * enemy_rocket.speed
	#var direction = path_follow_1.rotation  + PI / 2  + randf_range(-PI / 4, PI / 4)
	#var velocity_rotated = velocity.rotated(direction)
	#animated_sprite.rotation = direction + PI/2

	
func _on_enemy_rocket_timer_timeout():
	
	# Create a new instance of the Mob scene.
	var enemy_rocket = enemy_rocket_scene.instantiate()
	#var path_follow_1 = $EnemyRocketPath/EnamyRocketLocation
	#var path_follow_2 = $target/targetLocation
	#
	#generate_points(path_follow_1, path_follow_2, enemy_rocket)
	#
	#enemy_rocket.start_movement()
	#
	#enemy_rocket.position = path_follow_1.position

	# Choose a random location on Path2D.
	var enemy_rocket_location = $EnemyRocketPath/EnamyRocketLocation
	enemy_rocket_location.progress_ratio =  PI / 2 #randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = enemy_rocket_location.rotation  + PI / 2

	## Set the mob's position to a random location.
	enemy_rocket.position = enemy_rocket_location.position
#
	var enemy_rocket_target = $target/targetLocation
	enemy_rocket_target.progress_ratio =  randf()

	## Set the mob's position to a random location.
	enemy_rocket.frames = randi() % 500000 + 1000
	direction += randf_range(-PI / 4, PI / 4)
	
	enemy_rocket.direction = direction
	## Add some randomness to the direction.
#
	## Choose the velocity for the mob.
	#var speed =  randf_range(2, 8)
	#var velocity = Vector2(100, 0) * speed
	#var velocity_rotated = velocity.rotated(direction)
	#enemy_rocket.rotation = direction + PI/2
	#enemy_rocket.linear_velocity = velocity_rotated

	# Spawn the mob by adding it to the Main scene.
	add_scene_instance(enemy_rocket)
	add_child(enemy_rocket)

func _on_start_timer_timeout():
	$EnemyRocketTimer.start()
