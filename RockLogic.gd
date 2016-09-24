extends Spatial

var rock_Velocity = Vector3(0, 0, 0)
var rock_pos = Vector3(0, 0, 0)
var rock_rad = 3.0
var speed = 2.0
var rock_Type = 0
var hit = false


func _process(delta):
	pass


func _fixed_process(delta):
	rock_pos += rock_Velocity * delta

	if (rock_pos.x > 37.75):
		rock_pos.x = -37.75

	if (rock_pos.x < -37.75):
		rock_pos.x = 37.75

	if (rock_pos.y > 30):
		rock_pos.y = -30

	if (rock_pos.y < -30):
		rock_pos.y = 30

	self.set_translation(rock_pos)
	CheckCollision()


func Destroy():
	if (!hit):
		if (rock_Type == 0):
			get_node("/root/Asteroids").SpawnMedRocks(rock_pos)

		if (rock_Type == 1):
			get_node("/root/Asteroids").SpawnSmallRocks(rock_pos)

		if (rock_Type == 2):
			get_node("/root/Asteroids").SmallRockHit()

		hit = true
		self.set_hidden(true)
		self.set_process(false)
		self.queue_free()


func LargeRock():
	speed += randf() * 3
	var rockX
	Direction()

	if (rock_Velocity.x > 0):
		rockX = -37.75

	if (rock_Velocity.x < 0):
		rockX = 37.75

	rock_pos = Vector3(rockX, randf() *60 - 30, 0)
	self.set_translation(rock_pos)


func MedRock(var pos):
	rock_Type = 1
	RockPosition(pos)
	get_node("RockMesh").set_scale(Vector3(0.5, 0.5, 1))
	rock_rad = 1.5


func SmallRock(var pos):
	rock_Type = 2
	RockPosition(pos)
	get_node("RockMesh").set_scale(Vector3(0.25, 0.25, 1))
	rock_rad = 0.75


func RockPosition(var pos):
	rock_pos = pos
	speed += randf() *3 + 5
	self.set_translation(rock_pos)
	Direction()


func Get_RockType():
	return rock_Type


func Direction():
	var rad = rand_range(0, 6)
	rock_Velocity = Vector3(cos(rad) * speed, sin(rad) * speed, 0)


func CheckCollision():
	var playershots = get_tree().get_nodes_in_group("PlayerShot")

	for shot in playershots:
		if (shot.CirclesIntersect(rock_pos, rock_rad) && !shot.is_hidden()):
			if (rock_Type == 2):
				get_node("/root/Asteroids").PlayerHit(100)

			if (rock_Type == 1):
				get_node("/root/Asteroids").PlayerHit(50)

			if (rock_Type == 0):
				get_node("/root/Asteroids").PlayerHit(20)

			shot.Destroy()
			Destroy()

	if (!get_tree().get_nodes_in_group("Player").empty()):
		var player = get_node("/root/Asteroids/Player")

		if (player.CirclesIntersect(rock_pos, rock_rad)):
			if (rock_Type == 2):
				get_node("/root/Asteroids").PlayerHit(100)

			if (rock_Type == 1):
				get_node("/root/Asteroids").PlayerHit(50)

			if (rock_Type == 0):
				get_node("/root/Asteroids").PlayerHit(20)

			player.Destroy()
			get_node("/root/Asteroids").set_PlayerHit()
			Destroy()

	var UFOshots = get_tree().get_nodes_in_group("UFOShot")

	for shot in UFOshots:
		if (shot.CirclesIntersect(rock_pos, rock_rad)):
			shot.Destroy()
			Destroy()

	if (!get_tree().get_nodes_in_group("UFO").empty()):
		var UFO = get_node("/root/Asteroids/UFO")

		if (UFO.CirclesIntersect(rock_pos, rock_rad)):
			UFO.Destroy()
			Destroy()

func CirclesIntersect(var Target, var Radius):
	var dx = Target.x - rock_pos.x
	var dy = Target.y - rock_pos.y
	var rad = rock_rad + Radius

	if ((dx * dx) + (dy * dy) < rad * rad):
		return true
	
	return false


func _ready():
	#self.set_process(true)
	self.set_fixed_process(true)
	add_to_group("Rock")