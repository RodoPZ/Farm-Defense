extends Node

var player = {
	"Player": {
	"score": 0,
	"leche": 2,
	"hp": 3,
	"game_over": false,
	"paused": true
	}
}

var tower_data = {
	"Pollo": {
	"damage": 10,
	"rof": 2,
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
