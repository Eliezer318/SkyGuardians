extends Button

var all_scenes_array: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("scene_instance" ,_on_array_updated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_array_updated(scene_instance):
	# Use array_data here
	all_scenes_array.append(scene_instance)
	
func spawn_iron_dome_range(position):
	# Load the House scene
	var dome_scene = preload("res://scenes/iron_dome_range.tscn")       
	var black : Color = Color.BLACK
	# Instantiate the House scene as a child of this node
	var dome = dome_scene.instantiate()
	# Position the house at the center of the region
	dome.position = position
	add_child(dome)
	


func _on_pressed():
	var button_global_position = Vector2(global_position.x + 20, global_position.y + 23)
	spawn_iron_dome_range(button_global_position)
	#visible = false
	disabled = true
	$coolDownTimer.start()
	pass


func _on_cool_down_timer_timeout():
	disabled = false
	visible = true # Replace with function body.
