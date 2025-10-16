#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Ejercicicio que reciba dos cadenas de caracteres y compruebe si la primera está ordenada alfabéticamente respecto a la segunda

#Primero tenemos que recibir dos argumentos: 
if [ $# -ne 2 ]; then 
	echo "ERROR. Uso: ./ej6.sh arg1 arg2"
else
	if [[ "$1" > "$2" ]]; then
		echo "$1 está ordenada alfabéticamente respecto a $2"
	elif [[ "$1" < "$2" ]]; then
		echo "$1 no está ordenada alfabéticamente respecto a $2"
	else
		echo "$1 y $2 son iguales"
	fi
fi
