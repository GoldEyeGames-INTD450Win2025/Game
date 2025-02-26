extends ColorRect

func _ready():
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	var _canvas: CanvasLayer = $CenterContainer/CanvasLayer
	_canvas.visible = self.visible
