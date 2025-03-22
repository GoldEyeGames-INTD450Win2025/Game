extends Control

@onready var slider_sfx = $Panel/MarginContainer/VBoxContainer/HSlider_SFX
@onready var slider_music = $Panel/MarginContainer/VBoxContainer/HSlider_Music
@onready var startmenu = get_parent()
@onready var sfxtester = $SFXtester

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider_sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	slider_music.value = db_to_linear(AudioServer.get_bus_volume_db(1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_h_slider_sfx_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(slider_sfx.value))
	# play sfx sound to test 
	sfxtester.play()

func _on_h_slider_music_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(slider_music.value))


func _on_button_resume_pressed():
	startmenu.hide_options_menu()
