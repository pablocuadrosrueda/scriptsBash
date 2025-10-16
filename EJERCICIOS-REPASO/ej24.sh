#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Realice un guión de shell que toma como parámetros una serie de nombres de fichero
#de texto y muestra en la salida
#estándar el nombre del fichero que tenga más líneas. Si hay más de un fichero con el número
#máximo de líneas sólo debe
#mostrar el nombre de uno de ellos

#Comprobamos que recibimos un número igual o mayor a 1 de ficheros

if [[ $# < 1 ]]; then
	echo "ERROR. USO: $0 fich1 fich2 ... fichN"
else
	FICH=""
	max=-1
	for fich in $@; do
		if [ -f "$fich" ]; then 
			#LÍnea de depuraciÓn
			#echo "Procesando fichero $fich"
			lineas=$( wc -l $fich | cut -d" " -f1)
			#Linea de depuracion 
			#echo $lineas
			if [[ $lineas > $max ]]; then 
				FICH=$fich
				max=$lineas
			fi			
		fi	
	done
	echo "El fichero con mas lineas es el $FICH con $max lineas"
fi
