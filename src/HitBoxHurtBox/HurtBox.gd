extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")
onready var timer = $Timer
onready var hurtbox = $HurtBox

var invincible = false

signal invinciblity_started
signal invinciblity_ended

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	effect.global_position = global_position
	main.add_child(effect)

func start_invencibility(duration):
	self.invincible = true
	timer.start(duration)
	emit_signal("invinciblity_started")

func _on_Timer_timeout():
	self.invincible = false
	emit_signal("invinciblity_ended")

func _on_HurtBox_invinciblity_started():
	#set_deferred("monitoring", false)
	hurtbox.set_deferred("disabled", true)

func _on_HurtBox_invinciblity_ended():
	#monitoring = true
	hurtbox.disabled = false
