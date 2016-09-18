extends Spatial

var shot_Velocity = Vector3(0, 0, 0)
var shot_pos = Vector3(0, 0, 0)
var shot_rad = 0.2
var speed = 30
var hit = false
var playerOwned = true


func _process(delta):
	pass


func _fixed_process(delta):
	shot_pos += shot_Velocity * delta

	if (shot_pos.x > 37.75):
		shot_pos.x = -37.75

	if (shot_pos.x < -37.75):
		shot_pos.x = 37.75

	if (shot_pos.y > 30):
		shot_pos.y = -30

	if (shot_pos.y < -30):
		shot_pos.y = 30

	self.set_translation(shot_pos)


func FireShot(var position, var velocity, var offset):
	shot_pos = position + offset
	shot_Velocity = velocity
	self.set_translation(shot_pos)

func Destroy():
	if (playerOwned):
		var Player = get_tree().get_nodes_in_group("Player")

		if (!Player.empty()):
			get_node("/root/Asteroids/Player").set_ShotGone()
	else:
		var UFO = get_tree().get_nodes_in_group("UFO")

		if (!UFO.empty()):
			get_node("/root/Asteroids/UFO").set_ShotGone()

	self.set_hidden(true)
	self.set_process(false)
	self.queue_free()


func CirclesIntersect(var Target, var Radius):
	var dx = Target.x - shot_pos.x
	var dy = Target.y - shot_pos.y
	var rad = shot_rad + Radius

	if ((dx * dx) + (dy * dy) < rad * rad):
		return true
	
	return false


func _on_Timer_timeout():
	Destroy()


func set_PlayerShot():
	add_to_group("PlayerShot")


func set_UFOShot():
	add_to_group("UFOShot")
	playerOwned = false


func _ready():
	#self.set_process(true)
	self.set_fixed_process(true)
