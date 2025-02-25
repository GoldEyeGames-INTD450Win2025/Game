extends ColorRect


func _on_visibility_changed() -> void:
	var _canvas: CanvasLayer = $CenterContainer/CanvasLayer/PanelContainer
	_canvas.visible = self.visible
