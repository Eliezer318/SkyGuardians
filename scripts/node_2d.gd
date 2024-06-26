extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Define an array to store the regions
var width = 200
var height = 200

var rectangles = [
	Rect2(Vector2(260, 850), Vector2(530, 215)),
	Rect2(Vector2(365, 680), Vector2(425, 140)),
	Rect2(Vector2(435, 460), Vector2(400, 150)),
	Rect2(Vector2(520, 230), Vector2(340, 190)),
	Rect2(Vector2(555, 16), Vector2(310, 160)),
	# Add more rectangles as needed
]

func random_x_y(rectangle_idx):
	# Select a random rectangle
	var random_rectangle = rectangles[rectangle_idx]

	# Get the coordinates of the random rectangle
	var top_left = random_rectangle.position
	var bottom_right = random_rectangle.end

	# Generate a random point inside the rectangle
	var random_x = randi_range(top_left.x, bottom_right.x)
	var random_y = randi_range(top_left.y, bottom_right.y)
	var random_point = Vector2(random_x, random_y)
	return random_point

func spawn_domes(point):
	# Load the House scene
	var dome_scene = preload("res://scenes/iron_dome_button.tscn")
	var black : Color = Color.BLACK
	# Instantiate the House scene as a child of this node
	var dome = dome_scene.instantiate()
	add_child(dome)
	
	# Position the house at the center of the region
	dome.position = point
	


func generate_level(num_houses):
	# Spawn the specified number of iron domes
	for i in range(num_houses):
		for rect_idx in range(5):
			var random_point = random_x_y(rect_idx)
			spawn_domes(random_point)
		
func reset_level():
	generate_level(3)
	var main = preload("res://scenes/main.tscn").instantiate()
	add_child(main)

var cheat_code = ["ui_home", "ui_end"] # Define your cheat code sequence here
var input_index = 0 # Keep track of the current input index

func _input(event):
	# Check if the input event matches the next input in the cheat code sequenc
	if event.is_action_pressed("ui_home") and cheat_code[input_index] == "ui_home":
		input_index += 1
	elif event.is_action_pressed("ui_end") and cheat_code[input_index] == "ui_end":
		input_index += 1
	else:
	   # Reset input index if the input doesn't match the cheat code sequence
		input_index = 0
# If the entire cheat code sequence has been input, activate the cheat4
	if input_index == 2:
		use_cheat = true
	if use_cheat:
		for body in bodies_array:
			if is_instance_valid(body):
				body._on_interception()
		bodies_array = []
		use_cheat = false

var use_cheat = false
var bodies_array = []
func _on_area_2d_body_entered(body):
		bodies_array.push_back(body)
