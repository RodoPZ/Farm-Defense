extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type
var current_wave = 0
var enemies_in_wave = 0
var needed_score = 0
var game_started = false
var num_enemigos: int
var rng



func _ready():
	randomize()
	map_node = get_node("Map1")
	var entered_game_over = get_node("Map1/GameOver1")
	entered_game_over.connect("body_entered", self, "enemigo_entra_game_over")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed",self,"initiate_build_mode",[i.get_name()])

func _process(_delta):
	if build_mode:
		update_tower_preview()
	
	#Por alguna razón a veces score se vuelve mayor que needed_score y se desfasan las oleadas, si se encuentra el fallo quitar esto
	if needed_score < Data.player["Player"]["score"]:
		#print("xd")
		needed_score += Data.player["Player"]["score"] - needed_score

	#if(needed_score == Data.player["Player"]["score"] and current_wave != 10 and game_started):
	if(needed_score == Data.player["Player"]["score"] and game_started):
		start_next_wave()
	
	#print(needed_score)
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
### Funciones de oleadas ###
##

func start_next_wave():
	var wave_data = retrieve_wave_data()
	$UI/Path2D/PathFollow2D/WaveLabel.visible = true
	yield(get_tree().create_timer(5),"timeout") ##Tiempo entre oleadas para que no comiencen instantaneamente
	$UI/Path2D/PathFollow2D/WaveLabel.text = "Wave " + str(current_wave)
	$UI/Path2D/PathFollow2D/WaveLabel.visible = false
	spawn_enemies(wave_data)

func retrieve_wave_data():
	#print(current_wave)
	#Sale error aqui al final porque llega al limite de waves, alrato lo movemos jeje
	#for i in Data.wave["Wave"+str(current_wave)]["wave"]:
	#	needed_score += Data.enemigos[i[0]]["score"]	
	#var wave_data = Data.wave["Wave"+str(current_wave)]["wave"]	
	#enemies_in_wave = wave_data.size()
	#game_started = true
	#current_wave += 1
	
	#Singletons oleadas
	#var dificultad = Data.wave_data[map_node.name]["dificultad"]
	var ratio_crec_wave = Data.wave_data[map_node.name]["ratio_crec_wave"]
	var ratio_slime = Data.wave_data[map_node.name]["ratio_slime"]
	var ratio_esqueleto = Data.wave_data[map_node.name]["ratio_esqueleto"]
	var ratio_ogro = Data.wave_data[map_node.name]["ratio_ogro"]
	var prob_super_slimes = Data.wave_data[map_node.name]["prob_super_slimes"]
	var prob_super_esqueletos = Data.wave_data[map_node.name]["prob_super_esqueletos"]
	var prob_super_ogros = Data.wave_data[map_node.name]["prob_super_ogros"]
	var max_enemigos = Data.wave_data[map_node.name]["max_enemigos"]
	var var_num_enemies = Data.wave_data[map_node.name]["var_num_enemies"]
	
	var wave = []
	
	pickNumEnemies(ratio_crec_wave, var_num_enemies, max_enemigos)
	[ratio_slime, ratio_esqueleto, ratio_ogro] = checkSuperWave(ratio_slime, ratio_esqueleto, ratio_ogro, prob_super_esqueletos, prob_super_slimes, prob_super_ogros)
	for enemy in num_enemigos:
		generateEnemy(wave, ratio_slime, ratio_esqueleto, ratio_ogro)
	for i in wave:
		needed_score += Data.enemigos[i[0]]["score"]
	
	game_started = true
	current_wave += 1
	return wave

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemigos/" + i[0] + ".tscn").instance() 
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]),"timeout")

func enemigo_entra_game_over(body):
	for enemy in Data.enemigos:
		if enemy in body.get_parent().name:
			needed_score -= Data.enemigos[enemy]["score"]

func pickNumEnemies(ratio_crec_wave, var_num_enemies, max_enemigos):
	num_enemigos = round(current_wave * (ratio_crec_wave + rand_range(-var_num_enemies,var_num_enemies)))
	if num_enemigos > max_enemigos:
		num_enemigos = max_enemigos

func checkSuperWave(ratio_slime, ratio_esqueleto, ratio_ogro, prob_super_esqueletos, prob_super_slimes, prob_super_ogros):
	rng = randf()
	if rng < prob_super_slimes and current_wave >= 3:
		#print("SUPER SLIME")
		ratio_slime = .8
		ratio_esqueleto = .1
		ratio_ogro = .1
	elif prob_super_slimes < rng and rng < prob_super_slimes + prob_super_esqueletos and current_wave >= 5:
		#("SUPER ESQ")
		ratio_slime = .1
		ratio_esqueleto = .8
		ratio_ogro = .1
	elif prob_super_slimes + prob_super_esqueletos < rng and rng < prob_super_slimes + prob_super_esqueletos + prob_super_ogros and current_wave >= 8:
		#print("SUPER OGRO")
		ratio_slime = .25
		ratio_esqueleto = .25
		ratio_ogro = .5
	return [ratio_slime, ratio_esqueleto, ratio_ogro]
		
func generateEnemy(wave, ratio_slime, ratio_esqueleto, ratio_ogro):
	rng = randf()
	if rng < ratio_slime:
		wave.append(["Slime",rand_range(0.5,1)])
	elif ratio_slime < rng and rng < ratio_slime + ratio_esqueleto:
		if current_wave >= 3:
			wave.append(["Esqueleto",rand_range(0.5,2)])
		else:
			wave.append(["Slime",rand_range(0.5,1)])
	elif ratio_slime + ratio_esqueleto < rng and rng < ratio_slime + ratio_esqueleto + ratio_ogro:
		if current_wave >= 5:
			wave.append(["Ogro",rand_range(0.5,5)])
		elif current_wave >= 3:
			wave.append(["Esqueleto",rand_range(0.5,2)])
		else:
			wave.append(["Slime",rand_range(0.5,1)])
	

##
### Funciones de construcción ###
##
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type #+ T1, T2, etc
	if Data.player["Player"]["leche"] >= Data.tower_data[tower_type]["price"]:
		build_valid = false
		build_mode = true
		get_node("UI").set_tower_preview(build_type,get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("AllowedTorres").world_to_map(mouse_position)
	var tile_position = map_node.get_node("AllowedTorres").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		if map_node.get_node("AllowedTorres").get_cellv(current_tile)!=-1 and build_type !="Vaca":
			get_node("UI").update_tower_preview(tile_position,"ad54ff3c")
			build_valid = true
			build_location = tile_position
			build_tile = current_tile
		elif map_node.get_node("AllowedVaca").get_cellv(current_tile)!=-1 and build_type =="Vaca":
			get_node("UI").update_tower_preview(tile_position,"ad54ff3c")
			build_valid = true
			build_location = tile_position
			build_tile = current_tile
		else:
			get_node("UI").update_tower_preview(tile_position,"adff4545")
			build_valid = false
	else:
		get_node("UI").update_tower_preview(tile_position,"adff4545")
		build_valid = false
		
		
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()

func verify_and_build():
	if build_valid:
		Data.player["Player"]["leche"] -= Data.tower_data[build_type]["price"]
		var new_tower = load("res://Scenes/Torres/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		map_node.get_node("Torres").add_child(new_tower,true)
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 11)





