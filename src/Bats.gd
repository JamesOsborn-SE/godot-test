extends YSort

const BatEnemy = preload("res://Enemies/Bat.tscn")

onready var timer = $Timer
onready var topLeft = $"../Camera2D/Limits/TopLeft"
onready var bottomRight = $"../Camera2D/Limits/BottomRight"

export(int) var BatSpawnFreqency = 15
var batSpawnFreqency

func _ready():
	batSpawnFreqency = BatSpawnFreqency

func _on_Timer_timeout():
	randomize()
	var newBat = BatEnemy.instance()
	var randPosition = Vector2(
			rand_range(topLeft.position.x, bottomRight.position.x),
			rand_range(topLeft.position.y, bottomRight.position.y)
			)
	newBat.set("position", randPosition)
	get_parent().add_child(newBat)
	timer.start(batSpawnFreqency)
	
