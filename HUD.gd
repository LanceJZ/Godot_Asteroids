extends Spatial

var m_NumberNumberLineStart = []
var m_NumberNumberLineEnd = []
var m_LetterNumberLineStart = []
var m_LetterNumberLineEnd = []
var m_Numbers = []
var m_Letters = []
var m_ScorePos = Vector3(18, 28, 0)
var m_HighScorePos = Vector3(0, 28, 0)
var m_ShipsPos = Vector3(18, 24.5, 0)
var PlayerShipScene = load("res://PlayerShip.tscn")
var gameOver = false


func _process(delta):
	if (gameOver):
		pass


func ProcessScore(var number):
	get_node("Score").ClearMesh()
	var numberIn = number
	var space = 0

	if (numberIn == 0):
		MakeScoreMesh(numberIn, space, 1)

	while (numberIn > 0):
		var digit = numberIn % 10
		MakeScoreMesh(digit, space , 1)
		numberIn /= 10
		space += 2


func ProcessHighScore(var number):
	get_node("HighScore").ClearMesh()
	var numberIn = number
	var space = 0

	if (numberIn == 0):
		MakeHighScoreMesh(numberIn, space, 0.5)

	while (numberIn > 0):
		var digit = numberIn % 10
		MakeHighScoreMesh(digit, space, 0.5)
		numberIn /= 10
		space += 2


func MakeScoreMesh(var digit, var space, var size):
	if (digit > -1 && digit < 10):
		for line in range (7):
			if (m_Numbers[digit].Lines[line]):
				get_node("Score").ProcessMesh(NumberLineStart(line, space, size), NumberLineEnd(line, space, size))


func MakeHighScoreMesh(var digit, var space, var size):
	if (digit > -1 && digit < 10):
		for line in range (7):
			if (m_Numbers[digit].Lines[line]):
				get_node("HighScore").ProcessMesh(NumberLineStart(line, space, size), NumberLineEnd(line, space, size))


func NumberLineStart(var line, space, size):
	var startPos = Vector3(0, 0, 0)
	startPos.x = (m_NumberNumberLineStart[line].x + space) * size
	startPos.y = m_NumberNumberLineStart[line].y * size
	return startPos


func NumberLineEnd(var line, space, size):
	var endPos = Vector3(0, 0, 0)
	endPos.x = (m_NumberNumberLineEnd[line].x + space) * size
	endPos.y = m_NumberNumberLineEnd[line].y * size
	return endPos


func ProcessPlayerLives(var number):
	var playerShips = get_tree().get_nodes_in_group("PlayerShip")

	for ship in playerShips:
		ship.queue_free()

	if (number > 0):
		for ship in range (number):
			var shipNode = PlayerShipScene.instance()
			shipNode.translate(Vector3((ship * 1.15) + m_ShipsPos.x, m_ShipsPos.y, 0))
			shipNode.set_scale(Vector3(0.5, 0.5, 1))
			add_child(shipNode)
			shipNode.get_node("Ship").set_rotation(Vector3(0, 0, 1.57))


func _ready():
	InitializeNumberLines()
	InitializeLetterLines()
	set_process(true)
	get_node("Score").set_translation(m_ScorePos)
	get_node("HighScore").set_translation(m_HighScorePos)


func InitializeNumberLines():
	for i in range(10):
		m_Numbers.append(NumberData.new())

	m_NumberNumberLineStart.append(Vector3(0, 0, 0)) # Top Left
	m_NumberNumberLineStart.append(Vector3(-1, 0, 0)) # Top Right
	m_NumberNumberLineStart.append(Vector3(-1, -1, 0)) # Middle Right
	m_NumberNumberLineStart.append(Vector3(0, -2, 0)) # Bottom Left
	m_NumberNumberLineStart.append(Vector3(0, -1, 0)) # Middle Left
	m_NumberNumberLineStart.append(Vector3(0, 0, 0)) # Top Left
	m_NumberNumberLineStart.append(Vector3(0, -1, 0)) # Middle Left

	m_NumberNumberLineEnd.append(Vector3(-1, 0, 0)) # Right Top Line
	m_NumberNumberLineEnd.append(Vector3(-1, -1, 0)) # Right Middle Line
	m_NumberNumberLineEnd.append(Vector3(-1, -2, 0)) # Right Bottom Line
	m_NumberNumberLineEnd.append(Vector3(-1, -2, 0)) # Right Bottom Line
	m_NumberNumberLineEnd.append(Vector3(0, -2, 0)) # Left Bottom Line
	m_NumberNumberLineEnd.append(Vector3(0, -1, 0)) # Left Middle Line
	m_NumberNumberLineEnd.append(Vector3(-1, -1, 0)) # Right Middle Line
#0
	m_Numbers[0].Lines[0] = true
	m_Numbers[0].Lines[1] = true
	m_Numbers[0].Lines[2] = true
	m_Numbers[0].Lines[3] = true
	m_Numbers[0].Lines[4] = true
	m_Numbers[0].Lines[5] = true
	m_Numbers[0].Lines[6] = false
#1
	m_Numbers[1].Lines[0] = false
	m_Numbers[1].Lines[1] = true
	m_Numbers[1].Lines[2] = true
	m_Numbers[1].Lines[3] = false
	m_Numbers[1].Lines[4] = false
	m_Numbers[1].Lines[5] = false
	m_Numbers[1].Lines[6] = false
#2
	m_Numbers[2].Lines[0] = true
	m_Numbers[2].Lines[1] = true
	m_Numbers[2].Lines[2] = false
	m_Numbers[2].Lines[3] = true
	m_Numbers[2].Lines[4] = true
	m_Numbers[2].Lines[5] = false
	m_Numbers[2].Lines[6] = true
#3
	m_Numbers[3].Lines[0] = true
	m_Numbers[3].Lines[1] = true
	m_Numbers[3].Lines[2] = true
	m_Numbers[3].Lines[3] = true
	m_Numbers[3].Lines[4] = false
	m_Numbers[3].Lines[5] = false
	m_Numbers[3].Lines[6] = true
#4
	m_Numbers[4].Lines[0] = false
	m_Numbers[4].Lines[1] = true
	m_Numbers[4].Lines[2] = true
	m_Numbers[4].Lines[3] = false
	m_Numbers[4].Lines[4] = false
	m_Numbers[4].Lines[5] = true
	m_Numbers[4].Lines[6] = true
#5
	m_Numbers[5].Lines[0] = true
	m_Numbers[5].Lines[1] = false
	m_Numbers[5].Lines[2] = true
	m_Numbers[5].Lines[3] = true
	m_Numbers[5].Lines[4] = false
	m_Numbers[5].Lines[5] = true
	m_Numbers[5].Lines[6] = true
#6
	m_Numbers[6].Lines[0] = true
	m_Numbers[6].Lines[1] = false
	m_Numbers[6].Lines[2] = true
	m_Numbers[6].Lines[3] = true
	m_Numbers[6].Lines[4] = true
	m_Numbers[6].Lines[5] = true
	m_Numbers[6].Lines[6] = true
#7
	m_Numbers[7].Lines[0] = true
	m_Numbers[7].Lines[1] = true
	m_Numbers[7].Lines[2] = true
	m_Numbers[7].Lines[3] = false
	m_Numbers[7].Lines[4] = false
	m_Numbers[7].Lines[5] = false
	m_Numbers[7].Lines[6] = false
#8
	m_Numbers[8].Lines[0] = true
	m_Numbers[8].Lines[1] = true
	m_Numbers[8].Lines[2] = true
	m_Numbers[8].Lines[3] = true
	m_Numbers[8].Lines[4] = true
	m_Numbers[8].Lines[5] = true
	m_Numbers[8].Lines[6] = true
#9
	m_Numbers[9].Lines[0] = true
	m_Numbers[9].Lines[1] = true
	m_Numbers[9].Lines[2] = true
	m_Numbers[9].Lines[3] = false
	m_Numbers[9].Lines[4] = false
	m_Numbers[9].Lines[5] = true
	m_Numbers[9].Lines[6] = true


func InitializeLetterLines():
	for i in range(26):
		m_Letters.append(LetterData.new())

	m_LetterNumberLineStart.append(Vector3(0, 0, 0)) #0 Top Left Corner
	m_LetterNumberLineStart.append(Vector3(-1, 0, 0)) #1 Top Center
	m_LetterNumberLineStart.append(Vector3(-2, 0, 0)) #2 Top Right
	m_LetterNumberLineStart.append(Vector3(-2, -2, 0)) #3 Middle Right
	m_LetterNumberLineStart.append(Vector3(-1, -4, 0)) #4 Bottom Center
	m_LetterNumberLineStart.append(Vector3(0, -4, 0)) #5 Left Bottom
	m_LetterNumberLineStart.append(Vector3(0, -2, 0)) #6 Left Middle
	m_LetterNumberLineStart.append(Vector3(0, 0, 0)) #7 Top Left Corner
	m_LetterNumberLineStart.append(Vector3(0, 0, 0)) #8 Top Left Corner
	m_LetterNumberLineStart.append(Vector3(-2, 0, 0)) #9 Left Top Corner
	m_LetterNumberLineStart.append(Vector3(-1, -2, 0)) #10 Middle Center
	m_LetterNumberLineStart.append(Vector3(-1, -2, 0)) #11 Middle Center
	m_LetterNumberLineStart.append(Vector3(-1, -2, 0)) #12 Middle Center
	m_LetterNumberLineStart.append(Vector3(0, -2, 0)) #13 Left Middle
	m_LetterNumberLineStart.append(Vector3(-1, 0, 0)) #14 Top Center
	m_LetterNumberLineStart.append(Vector3(-1, -2, 0)) #15 Middle Center

	m_LetterNumberLineEnd.append(Vector3(-1, 0, 0)) #0 Top Center Line
	m_LetterNumberLineEnd.append(Vector3(-2, 0, 0)) #1 Top Right Line
	m_LetterNumberLineEnd.append(Vector3(-2, -2, 0)) #2 Middle Right Line
	m_LetterNumberLineEnd.append(Vector3(-2, -4, 0)) #3 Middle Bottom Line
	m_LetterNumberLineEnd.append(Vector3(-2, -4, 0)) #4 Right Bottom Line
	m_LetterNumberLineEnd.append(Vector3(-1, -4, 0)) #5 Center Bottom Line
	m_LetterNumberLineEnd.append(Vector3(0, -4, 0)) #6 Left Bottom Line
	m_LetterNumberLineEnd.append(Vector3(0, -2, 0)) #7 Left Middle Line
	m_LetterNumberLineEnd.append(Vector3(-1, -2, 0)) #8 Center Middle Line
	m_LetterNumberLineEnd.append(Vector3(-1, -2, 0)) #9 Center Middle Line
	m_LetterNumberLineEnd.append(Vector3(-2, -2, 0)) #10 Right Middle Line
	m_LetterNumberLineEnd.append(Vector3(-2, -4, 0)) #11 Right Bottom Line
	m_LetterNumberLineEnd.append(Vector3(0, -4, 0)) #12 Left Bottom Line
	m_LetterNumberLineEnd.append(Vector3(-1, -2, 0)) #13 Center Middle Line
	m_LetterNumberLineEnd.append(Vector3(-1, -2, 0)) #14 Center Middle Line
	m_LetterNumberLineEnd.append(Vector3(-1, -4, 0)) #15 Center Bottom Line
# A
	m_Letters[0].Lines[0] = true
	m_Letters[0].Lines[1] = true
	m_Letters[0].Lines[2] = true
	m_Letters[0].Lines[3] = true
	m_Letters[0].Lines[4] = false
	m_Letters[0].Lines[5] = false
	m_Letters[0].Lines[6] = true
	m_Letters[0].Lines[7] = true
	m_Letters[0].Lines[8] = false
	m_Letters[0].Lines[9] = false
	m_Letters[0].Lines[10] = true
	m_Letters[0].Lines[11] = false
	m_Letters[0].Lines[12] = false
	m_Letters[0].Lines[13] = true
	m_Letters[0].Lines[14] = false
	m_Letters[0].Lines[15] = false
# B
	m_Letters[1].Lines[0] = true
	m_Letters[1].Lines[1] = true
	m_Letters[1].Lines[2] = true
	m_Letters[1].Lines[3] = true
	m_Letters[1].Lines[4] = true
	m_Letters[1].Lines[5] = true
	m_Letters[1].Lines[6] = false
	m_Letters[1].Lines[7] = false
	m_Letters[1].Lines[8] = false
	m_Letters[1].Lines[9] = false
	m_Letters[1].Lines[10] = true
	m_Letters[1].Lines[11] = false
	m_Letters[1].Lines[12] = false
	m_Letters[1].Lines[13] = false
	m_Letters[1].Lines[14] = true
	m_Letters[1].Lines[15] = true
# C
	m_Letters[2].Lines[0] = true
	m_Letters[2].Lines[1] = true
	m_Letters[2].Lines[2] = false
	m_Letters[2].Lines[3] = false
	m_Letters[2].Lines[4] = true
	m_Letters[2].Lines[5] = true
	m_Letters[2].Lines[6] = true
	m_Letters[2].Lines[7] = true
	m_Letters[2].Lines[8] = false
	m_Letters[2].Lines[9] = false
	m_Letters[2].Lines[10] = false
	m_Letters[2].Lines[11] = false
	m_Letters[2].Lines[12] = false
	m_Letters[2].Lines[13] = false
	m_Letters[2].Lines[14] = false
	m_Letters[2].Lines[15] = false
# D
	m_Letters[3].Lines[0] = true
	m_Letters[3].Lines[1] = true
	m_Letters[3].Lines[2] = true
	m_Letters[3].Lines[3] = true
	m_Letters[3].Lines[4] = true
	m_Letters[3].Lines[5] = true
	m_Letters[3].Lines[6] = false
	m_Letters[3].Lines[7] = false
	m_Letters[3].Lines[8] = false
	m_Letters[3].Lines[9] = false
	m_Letters[3].Lines[10] = false
	m_Letters[3].Lines[11] = false
	m_Letters[3].Lines[12] = false
	m_Letters[3].Lines[13] = false
	m_Letters[3].Lines[14] = true
	m_Letters[3].Lines[15] = true
# E
	m_Letters[4].Lines[0] = true
	m_Letters[4].Lines[1] = true
	m_Letters[4].Lines[2] = false
	m_Letters[4].Lines[3] = false
	m_Letters[4].Lines[4] = true
	m_Letters[4].Lines[5] = true
	m_Letters[4].Lines[6] = true
	m_Letters[4].Lines[7] = true
	m_Letters[4].Lines[8] = false
	m_Letters[4].Lines[9] = false
	m_Letters[4].Lines[10] = false
	m_Letters[4].Lines[11] = false
	m_Letters[4].Lines[12] = false
	m_Letters[4].Lines[13] = true
	m_Letters[4].Lines[14] = false
	m_Letters[4].Lines[15] = false
# F
	m_Letters[5].Lines[0] = true
	m_Letters[5].Lines[1] = true
	m_Letters[5].Lines[2] = false
	m_Letters[5].Lines[3] = false
	m_Letters[5].Lines[4] = false
	m_Letters[5].Lines[5] = false
	m_Letters[5].Lines[6] = true
	m_Letters[5].Lines[7] = true
	m_Letters[5].Lines[8] = false
	m_Letters[5].Lines[9] = false
	m_Letters[5].Lines[10] = false
	m_Letters[5].Lines[11] = false
	m_Letters[5].Lines[12] = false
	m_Letters[5].Lines[13] = true
	m_Letters[5].Lines[14] = false
	m_Letters[5].Lines[15] = false
# G
	m_Letters[6].Lines[0] = true
	m_Letters[6].Lines[1] = true
	m_Letters[6].Lines[2] = false
	m_Letters[6].Lines[3] = true
	m_Letters[6].Lines[4] = true
	m_Letters[6].Lines[5] = true
	m_Letters[6].Lines[6] = true
	m_Letters[6].Lines[7] = true
	m_Letters[6].Lines[8] = false
	m_Letters[6].Lines[9] = false
	m_Letters[6].Lines[10] = true
	m_Letters[6].Lines[11] = false
	m_Letters[6].Lines[12] = false
	m_Letters[6].Lines[13] = false
	m_Letters[6].Lines[14] = false
	m_Letters[6].Lines[15] = false
# H
	m_Letters[7].Lines[0] = false
	m_Letters[7].Lines[1] = false
	m_Letters[7].Lines[2] = true
	m_Letters[7].Lines[3] = true
	m_Letters[7].Lines[4] = false
	m_Letters[7].Lines[5] = false
	m_Letters[7].Lines[6] = true
	m_Letters[7].Lines[7] = true
	m_Letters[7].Lines[8] = false
	m_Letters[7].Lines[9] = false
	m_Letters[7].Lines[10] = true
	m_Letters[7].Lines[11] = false
	m_Letters[7].Lines[12] = false
	m_Letters[7].Lines[13] = true
	m_Letters[7].Lines[14] = false
	m_Letters[7].Lines[15] = false
# I
	m_Letters[8].Lines[0] = true
	m_Letters[8].Lines[1] = true
	m_Letters[8].Lines[2] = false
	m_Letters[8].Lines[3] = false
	m_Letters[8].Lines[4] = true
	m_Letters[8].Lines[5] = true
	m_Letters[8].Lines[6] = false
	m_Letters[8].Lines[7] = false
	m_Letters[8].Lines[8] = false
	m_Letters[8].Lines[9] = false
	m_Letters[8].Lines[10] = false
	m_Letters[8].Lines[11] = false
	m_Letters[8].Lines[12] = false
	m_Letters[8].Lines[13] = false
	m_Letters[8].Lines[14] = true
	m_Letters[8].Lines[15] = true
# J
	m_Letters[9].Lines[0] = false
	m_Letters[9].Lines[1] = true
	m_Letters[9].Lines[2] = true
	m_Letters[9].Lines[3] = true
	m_Letters[9].Lines[4] = true
	m_Letters[9].Lines[5] = true
	m_Letters[9].Lines[6] = true
	m_Letters[9].Lines[7] = false
	m_Letters[9].Lines[8] = false
	m_Letters[9].Lines[9] = false
	m_Letters[9].Lines[10] = false
	m_Letters[9].Lines[11] = false
	m_Letters[9].Lines[12] = false
	m_Letters[9].Lines[13] = false
	m_Letters[9].Lines[14] = false
	m_Letters[9].Lines[15] = false
# K
	m_Letters[10].Lines[0] = false
	m_Letters[10].Lines[1] = false
	m_Letters[10].Lines[2] = false
	m_Letters[10].Lines[3] = false
	m_Letters[10].Lines[4] = false
	m_Letters[10].Lines[5] = false
	m_Letters[10].Lines[6] = true
	m_Letters[10].Lines[7] = true
	m_Letters[10].Lines[8] = false
	m_Letters[10].Lines[9] = true
	m_Letters[10].Lines[10] = false
	m_Letters[10].Lines[11] = true
	m_Letters[10].Lines[12] = false
	m_Letters[10].Lines[13] = true
	m_Letters[10].Lines[14] = false
	m_Letters[10].Lines[15] = false
# L
	m_Letters[11].Lines[0] = false
	m_Letters[11].Lines[1] = false
	m_Letters[11].Lines[2] = false
	m_Letters[11].Lines[3] = false
	m_Letters[11].Lines[4] = true
	m_Letters[11].Lines[5] = true
	m_Letters[11].Lines[6] = true
	m_Letters[11].Lines[7] = true
	m_Letters[11].Lines[8] = false
	m_Letters[11].Lines[9] = false
	m_Letters[11].Lines[10] = false
	m_Letters[11].Lines[11] = false
	m_Letters[11].Lines[12] = false
	m_Letters[11].Lines[13] = false
	m_Letters[11].Lines[14] = false
	m_Letters[11].Lines[15] = false
# M
	m_Letters[12].Lines[0] = false
	m_Letters[12].Lines[1] = false
	m_Letters[12].Lines[2] = true
	m_Letters[12].Lines[3] = true
	m_Letters[12].Lines[4] = false
	m_Letters[12].Lines[5] = false
	m_Letters[12].Lines[6] = true
	m_Letters[12].Lines[7] = true
	m_Letters[12].Lines[8] = true
	m_Letters[12].Lines[9] = true
	m_Letters[12].Lines[10] = false
	m_Letters[12].Lines[11] = false
	m_Letters[12].Lines[12] = false
	m_Letters[12].Lines[13] = false
	m_Letters[12].Lines[14] = false
	m_Letters[12].Lines[15] = false
# N
	m_Letters[13].Lines[0] = false
	m_Letters[13].Lines[1] = false
	m_Letters[13].Lines[2] = true
	m_Letters[13].Lines[3] = true
	m_Letters[13].Lines[4] = false
	m_Letters[13].Lines[5] = false
	m_Letters[13].Lines[6] = true
	m_Letters[13].Lines[7] = true
	m_Letters[13].Lines[8] = true
	m_Letters[13].Lines[9] = false
	m_Letters[13].Lines[10] = false
	m_Letters[13].Lines[11] = true
	m_Letters[13].Lines[12] = false
	m_Letters[13].Lines[13] = false
	m_Letters[13].Lines[14] = false
	m_Letters[13].Lines[15] = false
# O
	m_Letters[14].Lines[0] = true
	m_Letters[14].Lines[1] = true
	m_Letters[14].Lines[2] = true
	m_Letters[14].Lines[3] = true
	m_Letters[14].Lines[4] = true
	m_Letters[14].Lines[5] = true
	m_Letters[14].Lines[6] = true
	m_Letters[14].Lines[7] = true
	m_Letters[14].Lines[8] = false
	m_Letters[14].Lines[9] = false
	m_Letters[14].Lines[10] = false
	m_Letters[14].Lines[11] = false
	m_Letters[14].Lines[12] = false
	m_Letters[14].Lines[13] = false
	m_Letters[14].Lines[14] = false
	m_Letters[14].Lines[15] = false
# P
	m_Letters[15].Lines[0] = true
	m_Letters[15].Lines[1] = true
	m_Letters[15].Lines[2] = true
	m_Letters[15].Lines[3] = false
	m_Letters[15].Lines[4] = false
	m_Letters[15].Lines[5] = false
	m_Letters[15].Lines[6] = true
	m_Letters[15].Lines[7] = true
	m_Letters[15].Lines[8] = false
	m_Letters[15].Lines[9] = false
	m_Letters[15].Lines[10] = true
	m_Letters[15].Lines[11] = false
	m_Letters[15].Lines[12] = false
	m_Letters[15].Lines[13] = true
	m_Letters[15].Lines[14] = false
	m_Letters[15].Lines[15] = false
# Q
	m_Letters[16].Lines[0] = true
	m_Letters[16].Lines[1] = true
	m_Letters[16].Lines[2] = true
	m_Letters[16].Lines[3] = true
	m_Letters[16].Lines[4] = true
	m_Letters[16].Lines[5] = true
	m_Letters[16].Lines[6] = true
	m_Letters[16].Lines[7] = true
	m_Letters[16].Lines[8] = false
	m_Letters[16].Lines[9] = false
	m_Letters[16].Lines[10] = false
	m_Letters[16].Lines[11] = true
	m_Letters[16].Lines[12] = false
	m_Letters[16].Lines[13] = false
	m_Letters[16].Lines[14] = false
	m_Letters[16].Lines[15] = false
# R
	m_Letters[17].Lines[0] = true
	m_Letters[17].Lines[1] = true
	m_Letters[17].Lines[2] = true
	m_Letters[17].Lines[3] = false
	m_Letters[17].Lines[4] = false
	m_Letters[17].Lines[5] = false
	m_Letters[17].Lines[6] = true
	m_Letters[17].Lines[7] = true
	m_Letters[17].Lines[8] = false
	m_Letters[17].Lines[9] = false
	m_Letters[17].Lines[10] = true
	m_Letters[17].Lines[11] = true
	m_Letters[17].Lines[12] = false
	m_Letters[17].Lines[13] = true
	m_Letters[17].Lines[14] = false
	m_Letters[17].Lines[15] = false
# S
	m_Letters[18].Lines[0] = true
	m_Letters[18].Lines[1] = true
	m_Letters[18].Lines[2] = false
	m_Letters[18].Lines[3] = true
	m_Letters[18].Lines[4] = true
	m_Letters[18].Lines[5] = true
	m_Letters[18].Lines[6] = false
	m_Letters[18].Lines[7] = true
	m_Letters[18].Lines[8] = false
	m_Letters[18].Lines[9] = false
	m_Letters[18].Lines[10] = true
	m_Letters[18].Lines[11] = false
	m_Letters[18].Lines[12] = false
	m_Letters[18].Lines[13] = true
	m_Letters[18].Lines[14] = false
	m_Letters[18].Lines[15] = false
# T
	m_Letters[19].Lines[0] = true
	m_Letters[19].Lines[1] = true
	m_Letters[19].Lines[2] = false
	m_Letters[19].Lines[3] = false
	m_Letters[19].Lines[4] = false
	m_Letters[19].Lines[5] = false
	m_Letters[19].Lines[6] = false
	m_Letters[19].Lines[7] = false
	m_Letters[19].Lines[8] = false
	m_Letters[19].Lines[9] = false
	m_Letters[19].Lines[10] = false
	m_Letters[19].Lines[11] = false
	m_Letters[19].Lines[12] = false
	m_Letters[19].Lines[13] = false
	m_Letters[19].Lines[14] = true
	m_Letters[19].Lines[15] = true
# U
	m_Letters[20].Lines[0] = false
	m_Letters[20].Lines[1] = false
	m_Letters[20].Lines[2] = true
	m_Letters[20].Lines[3] = true
	m_Letters[20].Lines[4] = true
	m_Letters[20].Lines[5] = true
	m_Letters[20].Lines[6] = true
	m_Letters[20].Lines[7] = true
	m_Letters[20].Lines[8] = false
	m_Letters[20].Lines[9] = false
	m_Letters[20].Lines[10] = false
	m_Letters[20].Lines[11] = false
	m_Letters[20].Lines[12] = false
	m_Letters[20].Lines[13] = false
	m_Letters[20].Lines[14] = false
	m_Letters[20].Lines[15] = false
# V
	m_Letters[21].Lines[0] = false
	m_Letters[21].Lines[1] = false
	m_Letters[21].Lines[2] = false
	m_Letters[21].Lines[3] = false
	m_Letters[21].Lines[4] = false
	m_Letters[21].Lines[5] = false
	m_Letters[21].Lines[6] = true
	m_Letters[21].Lines[7] = true
	m_Letters[21].Lines[8] = false
	m_Letters[21].Lines[9] = true
	m_Letters[21].Lines[10] = false
	m_Letters[21].Lines[11] = false
	m_Letters[21].Lines[12] = true
	m_Letters[21].Lines[13] = false
	m_Letters[21].Lines[14] = false
	m_Letters[21].Lines[15] = false
# W
	m_Letters[22].Lines[0] = false
	m_Letters[22].Lines[1] = false
	m_Letters[22].Lines[2] = true
	m_Letters[22].Lines[3] = true
	m_Letters[22].Lines[4] = false
	m_Letters[22].Lines[5] = false
	m_Letters[22].Lines[6] = true
	m_Letters[22].Lines[7] = true
	m_Letters[22].Lines[8] = false
	m_Letters[22].Lines[9] = false
	m_Letters[22].Lines[10] = false
	m_Letters[22].Lines[11] = true
	m_Letters[22].Lines[12] = true
	m_Letters[22].Lines[13] = false
	m_Letters[22].Lines[14] = false
	m_Letters[22].Lines[15] = false
# X
	m_Letters[23].Lines[0] = false
	m_Letters[23].Lines[1] = false
	m_Letters[23].Lines[2] = false
	m_Letters[23].Lines[3] = false
	m_Letters[23].Lines[4] = false
	m_Letters[23].Lines[5] = false
	m_Letters[23].Lines[6] = false
	m_Letters[23].Lines[7] = false
	m_Letters[23].Lines[8] = true
	m_Letters[23].Lines[9] = true
	m_Letters[23].Lines[10] = false
	m_Letters[23].Lines[11] = true
	m_Letters[23].Lines[12] = true
	m_Letters[23].Lines[13] = false
	m_Letters[23].Lines[14] = false
	m_Letters[23].Lines[15] = false
# Y
	m_Letters[24].Lines[0] = false
	m_Letters[24].Lines[1] = false
	m_Letters[24].Lines[2] = false
	m_Letters[24].Lines[3] = false
	m_Letters[24].Lines[4] = false
	m_Letters[24].Lines[5] = false
	m_Letters[24].Lines[6] = false
	m_Letters[24].Lines[7] = false
	m_Letters[24].Lines[8] = true
	m_Letters[24].Lines[9] = true
	m_Letters[24].Lines[10] = false
	m_Letters[24].Lines[11] = false
	m_Letters[24].Lines[12] = false
	m_Letters[24].Lines[13] = false
	m_Letters[24].Lines[14] = false
	m_Letters[24].Lines[15] = true
# Z
	m_Letters[25].Lines[0] = true
	m_Letters[25].Lines[1] = true
	m_Letters[25].Lines[2] = false
	m_Letters[25].Lines[3] = false
	m_Letters[25].Lines[4] = true
	m_Letters[25].Lines[5] = true
	m_Letters[25].Lines[6] = false
	m_Letters[25].Lines[7] = false
	m_Letters[25].Lines[8] = false
	m_Letters[25].Lines[9] = true
	m_Letters[25].Lines[10] = false
	m_Letters[25].Lines[11] = false
	m_Letters[25].Lines[12] = true
	m_Letters[25].Lines[13] = false
	m_Letters[25].Lines[14] = false
	m_Letters[25].Lines[15] = false


class NumberData:
	var Lines = [false, false, false, false, false, false, false]

class LetterData:
	var Lines = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]