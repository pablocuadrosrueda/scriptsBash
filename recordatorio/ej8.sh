#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Escribe un programa que reciba una lista de directorios accesibles desde el directorio actual y liste el contenido de los mismos

#Primero comprobamos que al menor recibimos un argumento 

if [ $# -lt 1 ]; then
	echo "ERROR. USO: $0 dir1 dir2 dir3 ... dirN"
else
	for carpeta in $@; do
		#Comprobamos si el argumento carpeta-ésimo es una carpeta válida
		if [ -d $carpeta ]; then
			echo "El directorio $carpeta, es un directorio válido"
			echo "Listando contenido de la carpeta: $carpeta"
			ls $carpeta
		else
			echo "El directorio $carpeta, NO es un directorio válido"
		fi
	done
fi

