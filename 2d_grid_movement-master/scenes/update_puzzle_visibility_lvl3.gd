extends CanvasLayer
var one_time_activator = false
#@onready var demo_done_label = $PanelContainer2
@onready var sprite_mural_done = $/root/Map3/TileMapLayer2/Obstacles_Mural_Finished
@onready var completion_sound = $"/root/Map3/TileMapLayer2/Obstacles_Mural_Finished/completion_sound"
@onready var muralcomplete_detection_area = $"/root/Map3/TileMapLayer2/Obstacles_Mural_Finished/Area2D"
signal demo_done_music  # Define signal to later emit
func _ready():
	visibility_changed.connect(_on_visibility_changed)
	#Global.pieces_found = 3

func _on_visibility_changed() -> void:
	#var _canvas: CanvasLayer = $CanvasLayer
	#_canvas.visible = self.visible
	Global.puzzle_open = self.visible

func _process(_delta: float) -> void:
	if (Global.puzzle_solved == true) and (one_time_activator == false):
		one_time_activator = true
		#demo_done_label.show()
		sprite_mural_done.show()
		muralcomplete_detection_area.monitoring = true
		muralcomplete_detection_area.monitorable = true
		demo_done_music.emit()
		completion_sound.play()
		
