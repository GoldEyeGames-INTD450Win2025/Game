extends Node2D

@onready var logo1: AudioStreamPlayer2D = $Logo1
@onready var logo2: AudioStreamPlayer2D = $Logo2
@onready var action: AudioStreamPlayer2D = $Action
@onready var start: AudioStreamPlayer2D = $Start
@onready var completion: AudioStreamPlayer2D = $Completion
@onready var dialogue_advance: AudioStreamPlayer2D = $DialogueAdvance
@onready var grab_piece: AudioStreamPlayer2D = $GrabPiece

func play_sfx_logo1():
	logo1.play()

func play_sfx_logo2():
	logo2.play()

func play_sfx_action():
	action.play()

func play_sfx_start():
	start.play()

func play_sfx_completion():
	completion.play()

func play_sfx_dialogue_advance():
	dialogue_advance.play()

func play_sfx_grab_piece():
	grab_piece.play()
