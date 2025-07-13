extends Node2D

var current_player := 1  # 1 = Player 1, 2 = Player 2
@onready var pl1x = $CanvasLayer/LB1
@onready var break_sfx = $CanvasLayer/break_sfx
@onready var dead_sfx = $CanvasLayer/dead_sfx


func _ready():
	print("=== GAME SCENE STARTED ===")
	print("Player 1 selected: ", Gamedata.get_player1_box())
	print("Player 2 selected: ", Gamedata.get_player2_box())
	print("=== SELECTIONS COMPLETE ===")
	
	#Gamedata.is_game_started = true
	setup_game()

func setup_game():
	var all_boxes = get_tree().get_nodes_in_group("tapped_box")


	for box in all_boxes:
		box.mode = "gameplay"
		box.is_active = true
		box.connect("box_tapped", Callable(self, "_on_box_tapped"))

	print("Game setup complete. Player 1 starts.")
	pl1x.text = "Player 1's Turn"
func _on_box_tapped(box):
	if current_player == 1:
		pl1x.text = "Player 2's Turn"
		if box.name == Gamedata.get_player2_box() or box.name == Gamedata.get_player1_box():
			print("💀 Player 1 tapped Player 2's tile — Player 1 loses!")
			if(Soundtoggle.sfx_enabled == true):
				dead_sfx.play()
			box.play_die_animation()
			end_game(1)
		else:
			print("✅ Player 1 tapped safe tile")
			if(Soundtoggle.sfx_enabled == true):
				break_sfx.play()
			box.play_safe_animation()
			current_player = 2

	elif current_player == 2:
		pl1x.text = "Player 1's Turn"
		if box.name == Gamedata.get_player1_box() or box.name == Gamedata.get_player2_box():
			print("💀 Player 2 tapped Player 1's tile — Player 2 loses!")
			if(Soundtoggle.sfx_enabled == true):
				dead_sfx.play()
			box.play_die_animation()
			end_game(2)
		else:
			print("✅ Player 2 tapped safe tile")
			if(Soundtoggle.sfx_enabled == true):
				break_sfx.play()
			box.play_safe_animation()
			current_player = 1

func end_game(loser_player):
	print("=== GAME OVER ===")
	print("Player ", loser_player, " lost.")
	await get_tree().create_timer(2.0).timeout 
	var gameover = $CanvasLayer/gameover
	gameover.visible = true
	
	# Disable all boxes
	var all_boxes = get_tree().get_nodes_in_group("tapped_box")
	for box in all_boxes:
		box.is_active = false
	
	# Optional: show restart UI or delay + go back to main menu
