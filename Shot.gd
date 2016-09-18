
extends ImmediateGeometry


func _ready():
	self.begin(VS.PRIMITIVE_LINES, null)
	self.add_vertex(Vector3(-0.05, 0.0, 0))
	self.add_vertex(Vector3(0.05, 0.0, 0))
	self.add_vertex(Vector3(0.0, 0.05, 0))
	self.add_vertex(Vector3(0.0, -0.05, 0))
	self.end()
