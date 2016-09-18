extends ImmediateGeometry
var m_NumberLineStart = []
var m_NumberLineEnd = []
var m_Numbers = []


func ProcessScore(var number):
	self.clear()
	var numberIn = number
	var space = 0

	if (number == 0):
		NumberZero()

	while (numberIn > 0):
		var digit = numberIn % 10
		MakeScoreMesh(digit, space)
		numberIn /= 10
		space += 2


func ProcessHighScore(var number):
	get_node("HighScore").ClearMesh()
	var numberIn = number
	var space = 0

	while (numberIn > 0):
		var digit = numberIn % 10
		MakeHighScoreMesh(digit, space)
		numberIn /= 10
		space += 2



func MakeScoreMesh(var number, var space):
	if (number > -1 && number < 10):
		for line in range (7):
			if (m_Numbers[number].Lines[line]):
				self.begin(VS.PRIMITIVE_LINES, null)
				var Xstart = m_NumberLineStart[line].x + space
				var Ystart = m_NumberLineStart[line].y
				var Xend = m_NumberLineEnd[line].x + space
				var Yend = m_NumberLineEnd[line].y
				self.add_vertex(Vector3(Xstart, Ystart, 0.0))
				self.add_vertex(Vector3(Xend, Yend, 0.0))
				self.end()


func MakeHighScoreMesh(var number, var space):
	if (number > -1 && number < 10):
		for line in range (7):
			if (m_Numbers[number].Lines[line]):
				var Xstart = m_NumberLineStart[line].x + space - 50
				var Ystart = m_NumberLineStart[line].y
				var Xend = m_NumberLineEnd[line].x + space - 50
				var Yend = m_NumberLineEnd[line].y
				get_node("HighScore").ProcessMesh(Xstart, Ystart, Xend, Yend)


func _ready():
	InitializeNumberLines()


func InitializeNumberLines():
	m_NumberLineStart.append(Vector3(0, 0, 0))
	m_NumberLineStart.append(Vector3(-1, 0, 0))
	m_NumberLineStart.append(Vector3(-1, -1, 0))
	m_NumberLineStart.append(Vector3(0, -2, 0))
	m_NumberLineStart.append(Vector3(0, -1, 0))
	m_NumberLineStart.append(Vector3(0, 0, 0))
	m_NumberLineStart.append(Vector3(0, -1, 0))

	m_NumberLineEnd.append(Vector3(-1, 0, 0))
	m_NumberLineEnd.append(Vector3(-1, -1, 0))
	m_NumberLineEnd.append(Vector3(-1, -2, 0))
	m_NumberLineEnd.append(Vector3(-1, -2, 0))
	m_NumberLineEnd.append(Vector3(0, -2, 0))
	m_NumberLineEnd.append(Vector3(0, -1, 0))
	m_NumberLineEnd.append(Vector3(-1, -1, 0))

	for i in range(10):
		m_Numbers.append(NumberData.new())

	m_Numbers[0].Lines[0] = true
	m_Numbers[0].Lines[1] = true
	m_Numbers[0].Lines[2] = true
	m_Numbers[0].Lines[3] = true
	m_Numbers[0].Lines[4] = true
	m_Numbers[0].Lines[5] = true
	m_Numbers[0].Lines[6] = false

	m_Numbers[1].Lines[0] = false
	m_Numbers[1].Lines[1] = true
	m_Numbers[1].Lines[2] = true
	m_Numbers[1].Lines[3] = false
	m_Numbers[1].Lines[4] = false
	m_Numbers[1].Lines[5] = false
	m_Numbers[1].Lines[6] = false

	m_Numbers[2].Lines[0] = true
	m_Numbers[2].Lines[1] = true
	m_Numbers[2].Lines[2] = false
	m_Numbers[2].Lines[3] = true
	m_Numbers[2].Lines[4] = true
	m_Numbers[2].Lines[5] = false
	m_Numbers[2].Lines[6] = true

	m_Numbers[3].Lines[0] = true
	m_Numbers[3].Lines[1] = true
	m_Numbers[3].Lines[2] = true
	m_Numbers[3].Lines[3] = true
	m_Numbers[3].Lines[4] = false
	m_Numbers[3].Lines[5] = false
	m_Numbers[3].Lines[6] = true

	m_Numbers[4].Lines[0] = false
	m_Numbers[4].Lines[1] = true
	m_Numbers[4].Lines[2] = true
	m_Numbers[4].Lines[3] = false
	m_Numbers[4].Lines[4] = false
	m_Numbers[4].Lines[5] = true
	m_Numbers[4].Lines[6] = true

	m_Numbers[5].Lines[0] = true
	m_Numbers[5].Lines[1] = false
	m_Numbers[5].Lines[2] = true
	m_Numbers[5].Lines[3] = true
	m_Numbers[5].Lines[4] = false
	m_Numbers[5].Lines[5] = true
	m_Numbers[5].Lines[6] = true

	m_Numbers[6].Lines[0] = true
	m_Numbers[6].Lines[1] = false
	m_Numbers[6].Lines[2] = true
	m_Numbers[6].Lines[3] = true
	m_Numbers[6].Lines[4] = true
	m_Numbers[6].Lines[5] = true
	m_Numbers[6].Lines[6] = true

	m_Numbers[7].Lines[0] = true
	m_Numbers[7].Lines[1] = true
	m_Numbers[7].Lines[2] = true
	m_Numbers[7].Lines[3] = false
	m_Numbers[7].Lines[4] = false
	m_Numbers[7].Lines[5] = false
	m_Numbers[7].Lines[6] = false

	m_Numbers[8].Lines[0] = true
	m_Numbers[8].Lines[1] = true
	m_Numbers[8].Lines[2] = true
	m_Numbers[8].Lines[3] = true
	m_Numbers[8].Lines[4] = true
	m_Numbers[8].Lines[5] = true
	m_Numbers[8].Lines[6] = true

	m_Numbers[9].Lines[0] = true
	m_Numbers[9].Lines[1] = true
	m_Numbers[9].Lines[2] = true
	m_Numbers[9].Lines[3] = false
	m_Numbers[9].Lines[4] = false
	m_Numbers[9].Lines[5] = true
	m_Numbers[9].Lines[6] = true


func NumberZero():
	self.begin(VS.PRIMITIVE_LINES, null)

	self.add_vertex(Vector3(0, 0, 0))
	self.add_vertex(Vector3(-1, 0, 0)) #0

	self.add_vertex(Vector3(-1, 0, 0))
	self.add_vertex(Vector3(-1, -1, 0)) #1

	self.add_vertex(Vector3(-1, -1, 0))
	self.add_vertex(Vector3(-1, -2, 0)) #2

	self.add_vertex(Vector3(0, -2, 0))
	self.add_vertex(Vector3(-1, -2, 0)) #3

	self.add_vertex(Vector3(0, -1, 0))
	self.add_vertex(Vector3(0, -2, 0)) #4

	self.add_vertex(Vector3(0, 0, 0))
	self.add_vertex(Vector3(0, -1, 0)) #5

	self.end()

class NumberData:
	var Lines = [false, false, false, false, false, false, false]