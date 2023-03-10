extends Node

export(int) var max_health = 4 setget set_max_health_changed
var health = max_health setget set_health


signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_health(value):
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", value)
	if health <= 0:
		emit_signal("no_health")

func set_max_health_changed(value):
	self.health = min(health, value)
	emit_signal("max_health_changed", value)

func _ready():
	self.health= max_health
