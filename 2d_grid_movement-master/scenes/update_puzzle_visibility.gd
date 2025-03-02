extends ColorRect
var one_time_activator = false
@onready var demo_done_label = $CenterContainer/CanvasLayer/PanelContainer2
signal demo_done_music  # Define signal to later emit
func _ready():
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	var _canvas: CanvasLayer = $CenterContainer/CanvasLayer
	_canvas.visible = self.visible
	Global.puzzle_open = self.visible

func _process(_delta: float) -> void:
	if (Global.puzzle_solved == true) and (one_time_activator == false):
		one_time_activator = true
		demo_done_label.show()
		demo_done_music.emit()
		
