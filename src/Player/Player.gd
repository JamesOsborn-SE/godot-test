extends KinematicBody2D

export(int) var ACCELERATION = 500
export(int) var MAX_SPEED = 80
export(int) var FRICTION = 500
export(float) var  ROLL_SPEED = 2.5

enum{
	MOVE,
	ROLL,
	ATTACK
}


var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitBox =  $HitboxPivot/SwordHitBox
onready var hurtbox =  $HurtBox
onready var blinkAnimationPlayer = $Blink

signal ded

func _ready():
	randomize()
	stats.connect("no_health", self, "is_ded")
	animationTree.active = true
	swordHitBox.knockback_vector = roll_vector

func _physics_process(_delta):
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
		ROLL:
			roll_state()

func move_state():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() 
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		# I don't like this
		swordHitBox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

	move()
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func move():
	velocity = move_and_slide(velocity)

func roll_state():
	move()
	velocity = roll_vector * MAX_SPEED * ROLL_SPEED
	animationState.travel("Roll")

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func roll_end():
	velocity = velocity * 0.8
	state = MOVE
	
func attack_end():
	state = MOVE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	hurtbox.start_invencibility(0.6)
	
func is_ded():
	emit_signal("ded")
	queue_free()

func _on_HurtBox_invinciblity_started():
	blinkAnimationPlayer.play("Start")

func _on_HurtBox_invinciblity_ended():
	blinkAnimationPlayer.play("End")
