extends Node2D

var GrassEffect = preload("res://Effects/GrassEffect.tscn")

func kill_grass():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_HurtBox_area_entered(_area):
	kill_grass()
	queue_free()
