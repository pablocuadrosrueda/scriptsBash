#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Escribe un shell script que reciba exactamente un argumento que es el nombre de un directorio.
#A continuación compruebe si ya existe, y si no #existe que lo cree. Por último, tanto si existía previamente como si no, que le dé permisos

#Primero comprobamos el número de argumentos
if [ $# -ne 1 ]; then
	echo "ERROR, USO -> ./ej2.sh arg"
else
	#Comprobamos si no existe para crearlo en ese caso 
	if [ ! -d "$1" ]; then
		#Creamos el directorio 
		mkdir "$1"
	fi
	#En cualquiera de los casos le otorgamos permisos 700
	chmod 700 "$1" 
fi
