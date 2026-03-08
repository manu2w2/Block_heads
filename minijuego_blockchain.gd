extends Node2D

var bloque1 = ""
var bloque2 = ""
var bloque3 = ""

func registrar_color(nombre_bloque, color_dado):

	if nombre_bloque == "Bloque1":
		bloque1 = "rojo"
		
	if nombre_bloque == "Bloque2":
		bloque2 = color_dado
		
	if nombre_bloque == "Bloque3":
		bloque3 = color_dado

	revisar_orden()


func revisar_orden():

	# esperar a que los 3 bloques tengan dado
	if bloque1 == "" or bloque2 == "" or bloque3 == "":
		return

	if bloque1 == "ROJO" and bloque2 == "NARANJA" and bloque3 == "VERDE":
		
		# AQUÍ CAMBIAS LA ESCENA
		get_tree().change_scene_to_file("res://EscenaCorrecta.tscn")
