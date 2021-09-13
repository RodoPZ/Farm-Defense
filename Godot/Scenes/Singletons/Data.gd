extends Node

var player = {
	"Player": {
	"score": 0,
	"leche": 0,
	"hp": 3,
	"game_over": false	
	}
}

var tower_data = {
	"Pollo": {
	"damage": 10,
	"rof": 2,
	"range": 4},
	
	"Gallina":{
	"damage": 1,
	"rof": 1,
	"range": 4},
	
	"Puerco":{
	"damage":0,
	"rof": 1,
	"range": 4},
	
	"Cabra":{
	"damage": 1,
	"rof": .2,
	"range": 3},
	
	"Vaca":{
	"damage": 0,
	"rof": 1,
	"range": 0,
	"drop_time": 20}
	}

var enemigos ={
	"Slime":{
	"speed": 30,
	"hp": 5,
	"score": 1
	},
	
	"Esqueleto":{
	"speed": 14,
	"hp": 5,
	"score": 5
	},
	
	"Ogro":{
	"speed": 4,
	"hp": 5,
	"score": 20
	}
	}
