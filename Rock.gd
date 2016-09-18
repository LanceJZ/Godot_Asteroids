
extends ImmediateGeometry


func _ready():
	var rockShape = randi()%4

	if (rockShape == 0):
		RockOne()

	if (rockShape == 1):
		RockTwo()

	if (rockShape == 2):
		RockThree()

	if (rockShape == 3):
		RockFour()


func RockOne():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)

	self.add_vertex(Vector3(2.9, 1.5, 0.0))
	self.add_vertex(Vector3(1.5, 3.0, 0.0))
	self.add_vertex(Vector3(0.0, 2.2, 0.0))
	self.add_vertex(Vector3(-1.5, 3.0, 0.0))
	self.add_vertex(Vector3(-2.9, 1.5, 0.0))
	self.add_vertex(Vector3(-1.5, 0.7, 0.0))
	self.add_vertex(Vector3(-2.9, -0.7, 0.0))
	self.add_vertex(Vector3(-1.5, -3.0, 0.0))
	self.add_vertex(Vector3(0.7, -2.1, 0.0))
	self.add_vertex(Vector3(1.5, -3.0, 0.0))
	self.add_vertex(Vector3(2.9, -1.5, 0.0))
	self.add_vertex(Vector3(2.1, 0.0, 0.0))

	self.end()


func RockTwo():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)

	self.add_vertex(Vector3(2.9, 1.5, 0.0))
	self.add_vertex(Vector3(1.4, 2.9, 0.0))
	self.add_vertex(Vector3(0.0, 1.5, 0.0))
	self.add_vertex(Vector3(-1.5, 2.9, 0.0))
	self.add_vertex(Vector3(-2.9, 1.5, 0.0))
	self.add_vertex(Vector3(-2.2, 0.0, 0.0))
	self.add_vertex(Vector3(-2.9, -1.5, 0.0))
	self.add_vertex(Vector3(-0.7, -2.9, 0.0))
	self.add_vertex(Vector3(1.4, -2.9, 0.0))
	self.add_vertex(Vector3(2.9, -1.4, 0.0))

	self.end()


func RockThree():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)

	self.add_vertex(Vector3(2.9, 1.5, 0.0))
	self.add_vertex(Vector3(0.7, 1.5, 0.0))
	self.add_vertex(Vector3(1.6, 2.9, 0.0))
	self.add_vertex(Vector3(-0.8, 2.9, 0.0))
	self.add_vertex(Vector3(-2.9, 1.5, 0.0))
	self.add_vertex(Vector3(-2.9, 0.8, 0.0))
	self.add_vertex(Vector3(-0.8, 0.0, 0.0))
	self.add_vertex(Vector3(-2.9, -1.4, 0.0))
	self.add_vertex(Vector3(-1.4, -2.8, 0.0))
	self.add_vertex(Vector3(-0.7, -2.1, 0.0))
	self.add_vertex(Vector3(1.5, -2.9, 0.0))
	self.add_vertex(Vector3(2.9, -0.8, 0.0))

	self.end()


func RockFour():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)

	self.add_vertex(Vector3(2.9, 0.8, 0.0))
	self.add_vertex(Vector3(0.6, 2.9, 0.0))
	self.add_vertex(Vector3(-1.5, 2.9, 0.0))
	self.add_vertex(Vector3(-3.0, 0.7, 0.0))
	self.add_vertex(Vector3(-3.0, -0.7, 0.0))
	self.add_vertex(Vector3(-1.6, -2.9, 0.0))
	self.add_vertex(Vector3(-1.4, -2.9, 0.0))
	self.add_vertex(Vector3(0.0, -2.9, 0.0))
	self.add_vertex(Vector3(0.0, -0.8, 0.0))
	self.add_vertex(Vector3(1.4, -2.8, 0.0))
	self.add_vertex(Vector3(2.9, -0.7, 0.0))
	self.add_vertex(Vector3(1.5, -0.0, 0.0))

	self.end()