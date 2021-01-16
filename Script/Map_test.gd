extends Node2D

var tile_size = Vector2(32,32)
onready var texture = $Sprite.texture

func _ready():
	var tex_hight = texture.get_height()/tile_size.y
	var tex_width = texture.get_width()/tile_size.x
	var ts = TileSet.new()
	for x in range(tex_width):
		for y in range(tex_hight):
			var region = Rect2(x*tile_size.x,y*tile_size.y,tile_size.x,tile_size.y)
			var id = x + y * 16 
			
			ts.create_tile(id)
			ts.tile_set_region(id,region)
			ts.tile_set_texture(id, texture)
			ResourceSaver.save("res://terrian/TileMap_01.tres",ts)
