extends ImmediateGeometry


func ClearMesh():
	self.clear()


func ProcessMesh(var LineStart, var LineEnd):
	self.begin(VS.PRIMITIVE_LINES, null)
	self.add_vertex(LineStart)
	self.add_vertex(LineEnd)
	self.end()


func _ready():
	pass