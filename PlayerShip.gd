extends ImmediateGeometry

func _ready():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)
	self.add_vertex(Vector3(-1.15, 0.8, 0.0)) #Top back tip.
	self.add_vertex(Vector3(1.15, 0.0, 0.0)) #Nose pointing to the left of screen.
	self.add_vertex(Vector3(-1.15, -0.8, 0.0)) #Bottom back tip.
	self.add_vertex(Vector3(-0.95, -0.4, 0.0)) #Bottom inside back.
	self.add_vertex(Vector3(-0.95, 0.4, 0.0)) #Top inside back.
	self.end()
	self.set_rotation(Vector3(0, 0, randf() * 6.28))
