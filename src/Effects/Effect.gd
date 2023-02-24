extends AnimatedSprite

func _ready():
	var err = connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
	if err:
		print(err)
	play("default")

func _on_AnimatedSprite_animation_finished():
	queue_free()
