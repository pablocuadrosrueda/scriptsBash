#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Escribe un shell script que renombre todos los archivos ejecutables del directorio dado, de forma que le añada los caracteres . sh. Así si, por ejemplo, en ~/bin existe un archivo ejecutable llamado programa, debería renombrarlo para que se llame programa.sh

#Primero comprobamos el número de argumentos (debe ser 1)
if [ $# -ne 1 ]; then
	echo "ERROR: USO -> ./ej3.sh arg"
else
	#Ahora comprobamos que el argumento sea un directorio
	if [ ! -d "$1" ]; then	
		echo "ERROR: El archivo que se ha pasado por la cabecera no es un directorio"
	else
		#Si el archivo es un directorio debemos recorrer todos los archivos del mismo 
		for archivo in "$1"/*; do
			#Comprobamos si es archivo y si es ejecutable
			if [ -f "$archivo" ] && [ -x "$archivo" ]; then
				mv "$archivo" "$archivo.sh"
			fi
		done
	fi	
fi	
	
	
	
