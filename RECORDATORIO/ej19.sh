#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Escribe un shell script que reciba tres o más argumentos. El primero es un nombre, el
#segundo una extensión, y el tercero una lista de nombres
#de archivos. Escribe un shell script que renombre todos los archivos recibidos con el formato
#nombre-###.extensión donde nombre y extensión son los dos primeros
#recibidos y ### empieza en 000 y va incrementando.


#Recibimos tres argumentos

if [[ $# < 3 ]]; then
	#ERROR
	echo "ERROR. USO $0 nombre extension [ lista de nombres ]"
else
	#RECORREMOS EL DIRECTORIO /home/usuario_que_ejecuta/bin
	usu=$(whoami)
	dir="/home/$usu/bin"
	c=0
	# Primero guardamos los dos primeros argumentos
	nnombre=$1
	
	extension=$2
	# Desplazamos los argumentos dos posiciones a la izquierda
	shift 2
	for archivo in $@; do
		directorio=$( dirname $archivo )
		#mv $archivo $directorio/$nombre-$c.$extension
		contador=$( printf "%03d\n" $c )
		echo $contador
		echo $directorio/$nnombre-$contador.$extension
		((c++))
	done
fi
