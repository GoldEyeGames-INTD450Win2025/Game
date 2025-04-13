extends Node

var is_dragging = false
var pieces_found = 0
var puzzle_solved = false
var puzzle_open = false
var in_sandstorm = 0
var cat = null

var pause_menu_open = false
var dialogue_box_open = false

var saved_current_music_lvl = 0

var shine_material := preload("res://assets/scripts_backups/shine.tres")

var puzzle_solved_resettable = false
