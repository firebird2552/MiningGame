extends Label

func _ready():
    self.modulate = Color(1, 1, 1, 0)  # Initially transparent
    self.rect_min_size = Vector2(300, 40)  # Adjust size if needed
    self.add_theme_color_override("font_color", Color(1, 1, 1))  # Override font color
    self.show()

    # Tween to fade the toast in and out
    var tween = create_tween()
    tween.tween_property(self, "modulate:a", 1, 0.5)  # Fade in
    await(tween.finished)  # Wait for the fade in to finish
    await(get_tree().create_timer(2.0).timeout)  # Wait for 2 seconds
    tween.tween_property(self, "modulate:a", 0, 0.5)  # Fade out
    await(tween.finished)
    queue_free()  # Remove the toast from the scene
