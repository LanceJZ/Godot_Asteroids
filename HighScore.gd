extends ImmediateGeometry


func ClearMesh():
	self.clear()


func ProcessMesh(var Xstart, var Ystart, var Xend, var Yend):
	self.begin(VS.PRIMITIVE_LINES, null)
	self.add_vertex(Vector3(Xstart, Ystart, 0.0))
	self.add_vertex(Vector3(Xend, Yend, 0.0))
	self.end()


func _ready():
	pass