#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: La orden find con la opción -mtime busca archivos que se hayan modificado después de
#una fecha dada. Por ejemplo: find / -type f -mtime -4 busca todos los archivos del
#sistema que hayan sido modificados en los últimos cuatro días.
#Basándote en el ejercicio anterior, escribe un shell script que reciba como argumentos:
#un nombre, un número de días y varios directorios 
#y que cree un archivo comprimido con
#todos los archivos de los directorios que hayan sido modificados en los últimos n días
#(donde n es el parámetro que se pasa al script). El nombre del archivo debe ser [nombre]-
#[fecha].tar.gz donde [nombre] es el nombre que se pasa como argumento, [fecha]

#Comprobacion de parametros
if [[ $# < 3 ]]; then
	echo "ERROR. USO $0: nombre dias [dir1 ...  dirN]"
else
	#Recorremos los directorios en busca de archivos anteriores a la fecha dada
	nombre=$1
	dias=$2
	shift 2
	lista=""
	for dir in $@; do
		if [ -d "$dir" ]; then
			archivos=$(find $dir -type f -mtime -4) 
			echo "Procesando el directorio $dir"
			lista="$lista $archivos"								
		fi
	done
	#Ahora que tenemos todos los archivos en la variable lista ahcemos el zip
	#Si por algun error el nombre trajera alguna extensiÓn la eliminamos
	n=$nombre
	if [[ "$nombre" == *.* ]]; then
		n=$(echo "$n" | cut -d"." -f1)	
	fi
	tar czf "$n-$dias.tar.gz" $lista 
	if [ $? -eq 0 ]; then
		echo "EXITO"
	else
		echo "ERROR"
	fi
fi
