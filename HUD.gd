extends Spatial
var PlayerShipScene = load("res://PlayerShip.tscn")

func ProcessScore(var number):
	get_node("Score").ProcessScore(number)


func ProcessHighScore(var number):
	get_node("Score").ProcessHighScore(number)


func ProcessPlayerLives(var number):
	var playerShips = get_tree().get_nodes_in_group("PlayerShip")

	for ship in playerShips:
		ship.queue_free()

	if (number > 0):
		for ship in range (number):
			var shipNode = PlayerShipScene.instance()
			shipNode.translate(Vector3((ship * 1.15), -3.5, 0))
			shipNode.set_scale(Vector3(0.5, 0.5, 1))
			add_child(shipNode)
			shipNode.get_node("Ship").set_rotation(Vector3(0, 0, 1.57))


func _ready():
	pass