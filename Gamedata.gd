extends Node

var player1_box = ""
var player2_box = ""

func get_player1_box():
	return player1_box

func get_player2_box():
	return player2_box

func reset_game_data():
	player1_box = ""
	player2_box = ""

func get_player_box(player_id):
	if player_id == 1:
		return player1_box
	elif player_id == 2:
		return player2_box
	return ""
