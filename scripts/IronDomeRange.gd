extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	body._on_interception()
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	pass # Replace with function body.