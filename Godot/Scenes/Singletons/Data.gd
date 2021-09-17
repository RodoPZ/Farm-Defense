extends Node

var player = {
	"Player": {
	"score": 0,
	"leche": 99,
	"hp": 3,
	"game_over": false,
	"paused": true
	}
}

var tower_data = {
	"Pollo": {
	"damage": 3,
	"rof": 1,
	"range": 4,
	"price": 1},
	
	"Gallina":{
	"damage": 1,
	"rof": 1,
	"range": 4,
	"price": 2},
	
	"Puerco":{
	"damage":.5,
	"rof": 1,
	"range": 4,
	"price": 1},
	
	"Cabra":{
	"damage": 10,
	"rof": 5,
	"range": 3,
	"price": 1},
	
	"Vaca":{
	"damage": 0,
	"rof": 1,
	"range": 0,
	"drop_time": 30,
	"price": 1}
	}

var enemigos ={
	"Slime":{
	"speed": 8,
	"hp": 20,
	"score": 1
	},
	
	"Esqueleto":{
	"speed": 30,
	"hp": 8,
	"score": 5
	},
	
	"Ogro":{
	"speed": 4,
	"hp": 80,
	"score": 20
	}
	}

var wave={
	#No poner tiempo en 0 porque le da amnsiedad
	"Wave1":{
	"wave": [["Ogro",1]]
	},
	"Wave2":{
	"wave": [["Slime",1],["Slime",2],["Slime",3],["Slime",4],["Slime",5]]
	},
	"Wave3":{
	"wave": [["Esqueleto",1],["Esqueleto",1.3],["Esqueleto",1.6],["Esqueleto",1.9],["Esqueleto",1.2]]
	},
	"Wave4":{
	"wave": [["Slime",1],["Slime",2],["Slime",3],["Slime",4],["Slime",5],
			["Esqueleto",5],["Esqueleto",5.3],["Esqueleto",5.6],["Esqueleto",5.9],["Esqueleto",6.2]]
	}
}

var wave_data = {
	#Que los ratios de enemigos igualen 1
	"Map1":{
		"dificultad": 1,
		"ratio_crec_wave": 2,
		"ratio_slime": .5,
		"ratio_esqueleto": .3,
		"ratio_ogro": .2,
		"prob_super_slimes": .1,
		"prob_super_esqueletos": .2,
		"prob_super_ogros": .1,
		"max_enemigos": 999,
		"var_num_enemies": .4
		}
}
