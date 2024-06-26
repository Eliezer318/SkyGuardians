extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()

func change_score(score):
	$BestScore.text = str(score)
	
func show_game_over(score, best_score):
	show_message("GAME OVER")
	# Wait until the MessageTimer has counted down.
	$ScoreLabel.visible = false
	$scoreMessage.visible = false
	$lives.visible = false
	$livesMessage.visible = false
	$BestScore.visible = false
	$BastScoreLabel.visible = false
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.text = "START\n AGAIN"
	$myScore.text = "YOUR SCORE IS: " + str(score) +"\nBEST SCORE IS: " + str(best_score)
	$myScore.visible = true
	$StartButton.show()
# Called when the node enters the scene tree for the first time.

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_lives(lives):
	$lives.text = str(lives)

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	$ScoreLabel.visible = true
	$lives.visible = true
	$scoreMessage.visible = true
	$livesMessage.visible = true
	$BestScore.visible = true
	$BastScoreLabel.visible = true
	$myScore.visible = false
	start_game.emit()


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
