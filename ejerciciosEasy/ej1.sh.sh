#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Escribe un shell script que compruebe si se le han pasado entre dos y cuatro argu-mentos, en caso de que no se le hayan pasado ese número de #argumentos que escriba un error, y en caso de que sí se le hayan pasado que los escriba por pantalla

if [ $# -ge 2 ] && [ $# -le 4 ]; then
	i=1
	for arg in "$@"; do
		echo "Archivo número -> $i : $arg"
		((i++))
	done
else
	echo "ERROR, se deben introducir entre 2 y 4 argumentos"
fi
