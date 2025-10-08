#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Escribe un shell script al que se le pasan uno o varios directorios y un tamaño.
#Analiza esos directorios y renombra los archivos ordinarios en mayuscula si su tamaño es mayor o igual al pasado,
#y en minuscula si es inferior a ese tamaño.
#Para cada directorio calcula cuántos se han renombrado en mayus y cuántos en minus

####################################################################################################
						#NUEVO#
#${cadena^^} convierte toda la cadena a mayúsculas ${cadena,,} convierte toda la cadena a minúsculas
####################################################################################################


#Tenemos que admitir varios directorios
if [ $# -lt 1 ]; then
	echo "ERROR. USO $0 dir1 dir2 dir3 ... dirN tam"
else
	#Declaracion de contadores
	mayus=0
	minus=0
	#Nos quedamos con el tamaño
	tam=${!#}
	echo $tam
	#Tenemos que ir recorriendo los archivos y luego su contenido
	for dir in $@; do
		#Recorremos solo los directorios
		if [ -d $dir ]; then
			echo "$dir es un directorio"
			#Ahora tenemos que recorrer los archivos del directorio dir 
			for archivo in $dir/*; do
				#Primero comprobamos que lo que leemos sea un fichero válido
				if [ -f $archivo ]; then
					#obtenemos el nombre base del archivo
					nombre=$(basename $archivo)
					#obtenemos la ruta hasta el archivo
					ruta=$(dirname $archivo)
					echo $ruta
					tarchivo=$(stat $archivo -c %s)
					echo $archivo $ruta${nombre^^}
					if [[ $tarchivo -ge $tam ]]; then
						#Pasamos a mayúscula
						mv $archivo $ruta/${nombre^^}
						((mayus++))
					else
						#Pasamos a minúscula
						mv $archivo $ruta/${nombre,,}
						((minus++))
					fi 
				fi
			done
		fi
	done
	echo "MAYUS -> $mayus"
	echo "MINUS -> $minus"
fi
