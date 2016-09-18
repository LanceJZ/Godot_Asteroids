extends Spatial

var rockscene = load("res://Rock.tscn")
var UFOScene = load("res://UFO.tscn")
var Wave = 0
var UFOSpawnCount = 0
var numberOfLargeRocks = 4
var numberOfMedRocks = 0
var numberOfSmallRocks = 0
var SafeSpawn_pos = Vector3(0, 0, 0)
var SafeSpawn_rad = 10
var PlayerScore = 0
var PlayerHighScore = 0
var PlayerLives = 4
var playerHit = false
var playerSpawn = false


func _process(delta):
	if (playerSpawn):
		if (SafeToSpawn()):
			playerSpawn = false
			SpawnPlayer()

	if (playerHit):
		PlayerLives -= 1
		playerHit = false
		get_node("HUD").ProcessPlayerLives(PlayerLives)
		if (PlayerLives > 0):
			playerSpawn = true
	
	if (PlayerLives == 0):
		if (Input.is_action_pressed("NewGame")):
			NewGame()

	if (numberOfLargeRocks + numberOfMedRocks + numberOfSmallRocks < 1):
		numberOfLargeRocks = Wave + 4

		if (numberOfLargeRocks > 18):
			numberOfLargeRocks = 18

		SpawnLargeRocks()


func set_PlayerHit():
	playerHit = true


func SmallRockHit():
	numberOfSmallRocks -= 1


func PlayerHit(score):
	PlayerScore += score
	get_node("HUD").ProcessScore(PlayerScore)

	if (PlayerScore > PlayerHighScore):
		PlayerHighScore = PlayerScore
		get_node("HUD").ProcessHighScore(PlayerHighScore)


func SpawnSmallRocks(var pos):
	for i in range (2):
		var rocknode = rockscene.instance()
		rocknode.SmallRock(pos)
		add_child(rocknode)

	numberOfSmallRocks += 2
	numberOfMedRocks -= 1


func SpawnMedRocks(var pos):
	for i in range (2):
		var rocknode = rockscene.instance()
		rocknode.MedRock(pos)
		add_child(rocknode)

	numberOfMedRocks += 2
	numberOfLargeRocks -= 1


func SpawnLargeRocks():
	for i in range (numberOfLargeRocks):
		var rocknode = rockscene.instance()
		rocknode.LargeRock()
		add_child(rocknode)

	Wave += 1


func NewGame():
	playerHit = false
	playerSpawn = false
	Wave = 0
	PlayerScore = 0
	PlayerLives = 4
	UFOSpawnCount = 0
	numberOfLargeRocks = 4
	numberOfMedRocks = 0
	numberOfSmallRocks = 0

	var rocks = get_tree().get_nodes_in_group("Rock")

	for rock in rocks:
		rock.queue_free()

	var UFO = get_tree().get_nodes_in_group("UFO")

	for ufo in UFO:
		ufo.queue_free()

	var UFOshots = get_tree().get_nodes_in_group("UFOShot")

	for shot in UFOshots:
		shot.Destroy()

	SpawnPlayer()
	SpawnLargeRocks()
	get_node("HUD").ProcessScore(PlayerScore)
	get_node("HUD").ProcessPlayerLives(PlayerLives)


func SpawnPlayer():
	var playerShipscene = load("res://Player.tscn")
	var PlayerShipnode = playerShipscene.instance()
	add_child(PlayerShipnode)


func SpawnUFO():
	var UFOnode = UFOScene.instance()
	UFOnode.Spawn(UFOSpawnCount, Wave)
	add_child(UFOnode)
	UFOSpawnCount += 1


func SafeToSpawn():
	var UFOs = get_tree().get_nodes_in_group("UFO")
	var UFOshots = get_tree().get_nodes_in_group("UFOShot")
	var rocks = get_tree().get_nodes_in_group("Rock")

	for rock in rocks:
		if (rock.CirclesIntersect(SafeSpawn_pos, SafeSpawn_rad)):
			return false

	for UFO in UFOs:
		if (UFO.CirclesIntersect(SafeSpawn_pos, SafeSpawn_rad)):
			return false

	for UFOshot in UFOshots:
		if (UFOshot.CirclesIntersect(SafeSpawn_pos, SafeSpawn_rad)):
			return false

	return true


func CirclesIntersect(var Target, var Radius):
	var dx = Target.x - SafeSpawn_pos.x
	var dy = Target.y - SafeSpawn_pos.y
	var rad = SafeSpawn_rad + Radius

	if ((dx * dx) + (dy * dy) < rad * rad):
		return true
	
	return false


func _ready():
	randomize()
	set_process(true)
	NewGame()


func _on_TimerUFO_timeout():
	var UFO = get_tree().get_nodes_in_group("UFO")

	if (UFO.empty()):
		SpawnUFO()
