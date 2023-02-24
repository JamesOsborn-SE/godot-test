extends Control

var hearts = 4 setget set_hearts
var max_hearts =4 setget set_max_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_hearts(value):
	if heartUIFull != null:
		heartUIFull.rect_size.x = 15 * value
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = 15 * max_hearts

func set_max_hearts(value):
	max_hearts = value

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")
# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
