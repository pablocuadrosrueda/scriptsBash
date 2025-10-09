#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Escribe un shell script al que se le pasa un directorio y calcula el tamaño total
#que ocupan estos archivos.
#El script sólo suma su tamaño sólo si se trata de un fichero ordinario.
#Al final debe escribir por pantalla el número total de ficheros sumados y el tamaño total.

#Recibimos solo un argumento

if [[ $# != 1 ]]; then
	echo "ERROR. USO: $0 dir"
else
	#variable para acumular tamaños
	tam=0
	#Recorremos el directorio
	for archivo in $1/*; do 
		if [ -f $archivo ]; then
			t=$( stat -c %s "$archivo" )
			tam=$(( tam + t ))
		fi
	done
	echo "TAM TOTAL -> $tam"
fi


