#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Escribe un shell script que reciba dos o más argumentos que son nombres de
#directorios. 
#El primer
#directorio es el destino y los n-1 últimos directorios son los orígenes. El script debe copiar los
#archivos (sólo archivos ordinarios) de los n-1 últimos directorios en el directorio destino,
#siempre
#y cuando no haya un archivo con el mismo nombre en el directorio destino. Al final debe
#infomar del número de archivos copiados.

#Recibimos dos argumentos (dos directorios)
if [[ $# < 2 ]]; then 
	echo "ERROR. USO: $0 dir1 dir2"
else
	#Primer directorio es el destino
	destino=$1
	shift 1
	#Recorremos los directorios
	for dir in $@; do
		#Recorremos los archivos de los directorios 
		for arch in $dir/*; do
			if [ -f $arch ]; then
				#Si no existe ya un archivo con ese nombre  
				nombre_base=$( basename $arch )
				if [ ! -f $destino/$nombre_base ]; then 
					#cp $arch $destino
					cp $arch $destino
				fi
			fi
		done
	done
fi
