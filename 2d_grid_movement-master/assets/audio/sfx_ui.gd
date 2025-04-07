extends Node2D

@onready var lift: AudioStreamPlayer2D = $Lift
@onready var drop: AudioStreamPlayer2D = $Drop
@onready var slide: AudioStreamPlayer2D = $Slide

func play_sfx_lift():
	lift.play()

func play_sfx_drop():
	drop.play()

func play_sfx_slide():
	slide.play()
