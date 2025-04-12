extends Node2D

@onready var sound1: AudioStreamPlayer = $Piece
@onready var sound2: AudioStreamPlayer = $Dialo
@onready var sound3: AudioStreamPlayer = $OpenClose
@onready var sound4: AudioStreamPlayer = $OpenClose2
@onready var sound5: AudioStreamPlayer = $Transition

func play_sfx_piece():
	sound1.play()

func play_sfx_dialo():
	sound2.play()

func play_sfx_open_close():
	sound3.play()

func play_sfx_open_close2():
	sound4.play()

func play_transition_sound():
	sound5.play()
