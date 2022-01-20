extends Node2D

const section_time := 1.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 5.0
#const title_color := Color.blueviolet
const title_color := Color( 0.3, 0.2, 0.28, 1 )

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"Farm Defense",
		"Made with Godot Engine"
	],[
		"Programming",
		"Lead - Rodolfo Pinedo Suarez",
		"Luis Antonio Ramirez Garcia"
	],[
		"Art",
		"Luis Antonio Ramirez Garcia"
	],[
		"Music",
		"Luis Antonio Ramirez Garcia"
	],[
		"Sound Effects",
		"Luis Antonio Ramirez Garcia"
	],[
		"Dubbing",
		"Gusini (the stupid cow noise)"
	],[
		"Testers",
		"Missi",
		"Gusini",
		"Juampix",
		"Fridongui"
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Art created with Aseprite",
		"https://www.aseprite.org/",
		"",
		"Music created in Beepbox",
		"https://www.beepbox.co/",
		"",
		"Sound effects made in Jsfxr",
		"https://sfxr.me/",
		"",
		"Applied font",
		"04b_30",
		"https://www.dafont.com/04b-30.font",
		"",
		"Applied color palette",
		"https://lospec.com/palette-list/melody-16"
	],[
		"Special thanks",
		"Game Developer Center YouTube channel",
		"They have an amazing tower defense guide made",
		"in Godot. Go check it out!",
		"www.youtube.com/c/GameDevelopmentCenter"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene("res://SceneHandeler.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
