extends Node

var player = {
	"Score": 0,
	"Milk": 0,
	"HP": 0,
	"Game_Over": false	
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
	"Esqueleto":{
	"speed": 14,
	"hp": 5},
	
	"Ogro":{
	"speed": 4,
	"hp": 5},
	
	"Slime":{
	"speed": 8,
	"hp": 5}}
