extends RigidBody

var shotFired = false
var shotCount = 0
var prev_Fired = false
var prev_Hyper = false
var Ship_rad = 1.15
var Ship_pos = Vector3(0, 0, 0)
var Ship_hit = false


func _fixed_process(delta):
	Ship_pos = self.get_translation()

	if (Ship_pos.x > 37.75):
		Ship_pos.x = -37.75
		self.set_translation(Ship_pos)

	if (Ship_pos.x < -37.75):
		Ship_pos.x = 37.75
		self.set_translation(Ship_pos)

	if (Ship_pos.y > 28.5):
		Ship_pos.y = -28.5
		self.set_translation(Ship_pos)

	if (Ship_pos.y < -28.5):
		Ship_pos.y = 28.5
		self.set_translation(Ship_pos)

	CheckCollision()

	if (get_linear_velocity().x > 50):
		self.set_linear_velocity(Vector3(50, self.get_linear_velocity().y, 0))

	if (get_linear_velocity().x < -50):
		self.set_linear_velocity(Vector3(-50, self.get_linear_velocity().y, 0))

	if (get_linear_velocity().y > 50):
		self.set_linear_velocity(Vector3(self.get_linear_velocity().x, 50, 0))

	if (get_linear_velocity().y < -50):
		self.set_linear_velocity(Vector3(self.get_linear_velocity().x, -50, 0))


func _process(delta):
	if (Input.is_action_pressed("Rotate_Left")):
		get_node("Ship").set_rotation(get_node("Ship").get_rotation() + Vector3(0, 0,  -5 * delta))

	if (Input.is_action_pressed("Rotate_Right")):
		get_node("Ship").set_rotation(get_node("Ship").get_rotation() + Vector3(0, 0, 5 * delta))

	if (Input.is_action_pressed("Thrust")):
		var shipRot = get_node("/root/Asteroids/Player/Ship").get_rotation().z
		self.apply_impulse(Vector3(0, 0, 0), Vector3(cos(shipRot), sin(shipRot), 0) * delta * 2)

	var hyper = Input.is_action_pressed("Hyperspace")
	var fire = Input.is_action_pressed("Fire")

	if (fire and !prev_Fired and shotCount < 4 and !shotFired):
		FireShot()

	if (hyper and !prev_Hyper):
		self.set_translation(Vector3(rand_range(-37, 37), rand_range(-30, 30), 0))

	prev_Hyper = hyper
	prev_Fired = fire


func CheckCollision():
	var UFOshots = get_tree().get_nodes_in_group("UFOShot")

	for shot in UFOshots:
		if (shot.CirclesIntersect(Ship_pos, Ship_rad)):
			shot.Destroy()
			Destroy()
			get_node("/root/Asteroids").set_PlayerHit()


func FireShot():
	var shotScene = preload("res://Shot.tscn").instance()
	shotScene.set_PlayerShot()
	var player_rot = get_node("Ship").get_rotation().z
	var player_pos = get_translation()
	var offset_pos = Vector3(cos(player_rot) * 1.15, sin(player_rot) * 1.15, 0)
	shotScene.FireShot(player_pos, Vector3(cos(player_rot) * 30, sin(player_rot) * 30, 0), offset_pos)
	get_node("/root/Asteroids").add_child(shotScene)
	shotCount += 1
	shotFired = true
	get_node("FireTimer").start()


func set_ShotGone():
	shotCount -= 1


func Destroy():
	self.set_hidden(true)
	self.set_process(false)
	self.queue_free()


func CirclesIntersect(var Target, var Radius):
	var dx = Target.x - Ship_pos.x
	var dy = Target.y - Ship_pos.y
	var rad = Ship_rad + Radius

	if ((dx * dx) + (dy * dy) < rad * rad):
		return true
	
	return false


func _on_FireTimer_timeout():
	shotFired = false


func _ready():
	self.set_process(true)
	self.set_fixed_process(true)
	add_to_group("Player")
