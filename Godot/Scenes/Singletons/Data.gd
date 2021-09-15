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
	"damage": 1,
	"rof": 1,
	"range": 4,
	"price": 1},
	
	"Gallina":{
	"damage": 1,
	"rof": 1,
	"range": 4,
	"price": 2},
	
	"Puerco":{
	"damage":0,
	"rof": 1,
	"range": 4,
	"price": 1},
	
	"Cabra":{
	"damage": 1,
	"rof": .2,
	"range": 3,
	"price": 1},
	
	"Vaca":{
	"damage": 0,
	"rof": 1,
	"range": 0,
	"drop_time": 20,
	"price": 1}
	}

var enemigos ={
	"Slime":{
	"speed": 15,
	"hp": 10,
	"score": 1
	},
	
	"Esqueleto":{
	"speed": 14,
	"hp": 5,
	"score": 5
	},
	
	"Ogro":{
	"speed": 4,
	"hp": 20,
	"score": 20
	}
	}

var wave={
	#No poner tiempo en 0 porque le da amnsiedad
	"Wave1":{
	"wave": [["Slime",1],["Slime",2]]
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
