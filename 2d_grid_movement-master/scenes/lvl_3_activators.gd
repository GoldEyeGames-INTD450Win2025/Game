extends Node2D

@onready var label2_title : RichTextLabel  = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/Label2
#@onready var label3_num_left : RichTextLabel = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/Label3
var pieces_left = 3
@onready var corner_pics : Node2D = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/Node2D
@onready var corner_pic1_revealed : Sprite2D = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/RuinPiece1
@onready var corner_pic2_revealed : Sprite2D = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/RuinPiece2
@onready var corner_pic3_revealed : Sprite2D = $/root/Map3/Player_Char2D/MainUI/CanvasLayer/RuinPiece3
#@onready var musicmanager = $"../Player_Char2D/MusicManager3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.pieces_found = 0
	Global.puzzle_solved = false
	var zone_mural = get_node("/root/Map3/Lvl3Activators/A3_Mural")  # Adjust path as needed
	if zone_mural:
		zone_mural.player_near_lvl3_mural.connect(_on_player_nearby_Mural)
		print("Connected to mural: player_near_lvl3_mural")
	var zone_piece1 = get_node("/root/Map3/Lvl3Activators/APiece1")  # Adjust path as needed
	if zone_piece1:
		zone_piece1.player_near_lvl3_AP1.connect(_on_player_nearby_Piece1)
		print("Connected to piece signal 1")
	var zone_piece2 = get_node("/root/Map3/Lvl3Activators/APiece2")  # Adjust path as needed
	if zone_piece2:
		zone_piece2.player_near_lvl3_AP2.connect(_on_player_nearby_Piece2)
		print("Connected to piece signal 2")
	var zone_piece3 = get_node("/root/Map3/Lvl3Activators/APiece3")  # Adjust path as needed
	if zone_piece3:
		zone_piece3.player_near_lvl3_AP3.connect(_on_player_nearby_Piece3)
		print("Connected to piece signal 3")

func _on_player_nearby_Mural():
	print("_on_player_nearby_Mural")
	label2_title.show()
	corner_pics.show()
	print("Global.pieces_found" + str(Global.pieces_found))

func _on_player_nearby_Piece1():
	print("_on_player_nearby_Piece1")
	label2_title.show()
	corner_pics.show()
	pieces_left = pieces_left - 1
	Global.pieces_found = 3 - pieces_left
	update_corner_pic_reveal()
	print("Global.pieces_found" + str(Global.pieces_found))

func _on_player_nearby_Piece2():
	print("_on_player_nearby_Piece2")
	label2_title.show()
	corner_pics.show()
	pieces_left = pieces_left - 1
	Global.pieces_found = 3 - pieces_left
	update_corner_pic_reveal()
	print("Global.pieces_found" + str(Global.pieces_found))

func _on_player_nearby_Piece3():
	print("_on_player_nearby_Piece3")
	label2_title.show()
	corner_pics.show()
	pieces_left = pieces_left - 1
	Global.pieces_found = 3 - pieces_left
	update_corner_pic_reveal()
	print("Global.pieces_found" + str(Global.pieces_found))

func update_corner_pic_reveal():
	if pieces_left == 2:
		corner_pic1_revealed.show()
	elif pieces_left == 1:
		corner_pic2_revealed.show()
	elif pieces_left == 0:
		corner_pic3_revealed.show()
		#musicmanager._on_demoDone()
