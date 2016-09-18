extends Spatial

var UFO_Velocity = Vector3(0, 0, 0)
var UFO_pos = Vector3(0, 0, 0)
var UFO_rad = 2
var UFO_Speed = 5
var UFO_ShotActive = false
var UFO_Size = 0 # UFO_Size 0 is large, 1 is small


func _fixed_process(delta):
	UFO_pos += UFO_Velocity * delta

	if (UFO_pos.x > 37.75):
		Destroy()

	if (UFO_pos.x < -37.75):
		Destroy()

	if (UFO_pos.y > 28.5):
		UFO_pos.y = -28.5

	if (UFO_pos.y < -28.5):
		UFO_pos.y = 28.5

	self.set_translation(UFO_pos)
	CheckCollision()


func FireShot():
	var shotScene = preload("res://Shot.tscn").instance()
	shotScene.set_UFOShot()
	var offsetUFO_Size = 2 - UFO_Size
	var shot_Speed = 25
	var is_Aimed = rand_range(0, 10)
	var shot_Direction = rand_range(0, 6)

	if (is_Aimed < 7.5 && UFO_Size == 1):
		if (!get_tree().get_nodes_in_group("Player").empty()):
			var player_pos = get_node("/root/Asteroids/Player").get_translation()
			shot_Direction = atan2(player_pos.y - UFO_pos.y, player_pos.x - UFO_pos.x)

	var offset_pos = Vector3(cos(shot_Direction) * offsetUFO_Size, sin(shot_Direction) * offsetUFO_Size, 0)
	shotScene.FireShot(UFO_pos, Vector3(cos(shot_Direction) * shot_Speed, sin(shot_Direction) * shot_Speed, 0), offset_pos)
	get_node("/root/Asteroids").add_child(shotScene)
	get_node("TimerShot").start()
	UFO_ShotActive = true


func VectorChange():
	var change = rand_range(0, 10)

	if (change < 5):
		if (UFO_Velocity.y == 0 && change < 2.5):
			UFO_Velocity.y = UFO_Speed
		elif (UFO_Velocity.y == 0):
			UFO_Velocity.y = -UFO_Speed
		else:
			UFO_Velocity.y = 0


func CheckCollision():
	if (!get_tree().get_nodes_in_group("Player").empty()):
		var PlayerShip = get_node("/root/Asteroids/Player")

		if (PlayerShip.CirclesIntersect(UFO_pos, UFO_rad)):
			if (UFO_Size == 0):
				get_node("/root/Asteroids").PlayerHit(200)

			if (UFO_Size == 1):
				get_node("/root/Asteroids").PlayerHit(1000)

			PlayerShip.Destroy()
			get_node("/root/Asteroids").set_PlayerHit()
			Destroy()

	var playershots = get_tree().get_nodes_in_group("PlayerShot")

	for shot in playershots:
		if (shot.CirclesIntersect(UFO_pos, UFO_rad)):
			if (UFO_Size == 0):
				get_node("/root/Asteroids").PlayerHit(200)

			if (UFO_Size == 1):
				get_node("/root/Asteroids").PlayerHit(1000)

			shot.Destroy()
			Destroy()


func CirclesIntersect(var Target, var Radius):
	var dx = Target.x - UFO_pos.x
	var dy = Target.y - UFO_pos.y
	var rad = UFO_rad + Radius

	if ((dx * dx) + (dy * dy) < rad * rad):
		return true
	
	return false


func set_ShotGone():
	UFO_ShotActive = false


func Destroy():
	self.set_hidden(true)
	self.set_process(false)
	self.queue_free()


func Spawn(var spawnCount, var wave):
	var spawnPercent = (pow(0.915, (spawnCount * 2) / ((wave * 2) + 1)))
	var side = rand_range(0, 10)

	if (rand_range(0, 99) > spawnPercent * 100):
		get_node("UFOMesh").set_scale(Vector3(0.5, 0.5, 1))
		UFO_Size = 1

	UFO_pos.y = rand_range(-20, 20)

	if (side > 5):
		UFO_pos.x = 37.75
		UFO_Velocity.x = -UFO_Speed
	else:
		UFO_pos.x = -37.75
		UFO_Velocity.x = UFO_Speed

	self.set_translation(UFO_pos)

func _ready():
	self.set_fixed_process(true)
	add_to_group("UFO")


func _on_TimerVector_timeout():
	VectorChange()


func _on_TimerShot_timeout():
	if (!UFO_ShotActive):
		FireShot()
