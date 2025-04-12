extends Node2D

@onready var sound1: AudioStreamPlayer = $Piece
@onready var sound2: AudioStreamPlayer = $Dialo
@onready var sound3: AudioStreamPlayer = $PuzzleOpenClose

func play_sfx_piece():
	sound1.play()

func play_sfx_dialo():
	sound2.play()

func play_sfx_puzzle_open_close():
	sound3.play()
