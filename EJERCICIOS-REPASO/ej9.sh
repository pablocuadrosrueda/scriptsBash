#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Escribe un script que reciba exactamente dos directorios accesisbles desde el directorio actual y copie los archivos del primero en el segundo
#siempre y cuando no existan ya en el segundo directorio o bien que el archivo que se copia sea más reciente que el que se sobreescribe


#Comprobamos que recibimos dos argumentos y que ambos son directorios
if [ $# -ne 2 ]; then
	echo "ERROR. USO: ./ej9.sh dir1 dir2"
else
	if [ ! -d $1 ]; then
		echo "El arg: $1 no es un directorio válido"
	else
		if [ ! -d $2 ]; then
			echo "El arg $ no es un directorio válido"
		else
			echo "Procediendo a la copia de archivos..."
			for archivo in $1; do
				#Primero comprobamos que el archivo no existe en el segundo directorio
				if [ ! -f "$2/$archivo" ]; then
    					# Caso 1: no existe -> copiar
    					cp "$archivo" "$2"
				elif [ "$archivo" -nt "$2/$archivo" ]; then
    				# Caso 2: existe y es más antiguo -> sobrescribir
    					cp "$archivo" "$2"
			done
		fi
	fi 
fi
