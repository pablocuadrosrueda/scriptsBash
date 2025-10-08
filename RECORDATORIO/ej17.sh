#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Shell script que recorra ~/bin y si detecta un archivo que termine en .sh sin permisos
#de ejecución, se los asigne,
#cualquier otro archivo que tenga dichos permisos, sin acabar en .sh, debe perderlos.
#Debe decir cuántos archivos han sido activados, y cuántos desactivados.


#Este programa no espera recibir argumentos
if [[ $# != 0 ]]; then
	echo "ERROR. USO -> $0"
else
	#Definimos contadores
	activados=0
	desactivados=0
	#Ahora recorremos el directorio bin ( del usuario que esté ejecutando el script
	usu=$(whoami)
	dir="/home/$usu/bin"
	for a in $dir/*; do
		#Ahora tenemos que detectar que la terminación sea .sh
		if [[ $a == *.sh ]]; then
			#Si el archivo con terminacion sh no tiene permisos de ejecución se los damos
			if [ ! -x $a ]; then
				chmod +x $a
				((activados++))
			fi
		#Para los que no acaben sh, de tener permisos de ejecución los debe perder
		else
			if [ -x $a ]; then
				chmod -x $a
				((desactivados++))
			fi
		fi
	done
	
	echo "ACTIVADOS -> $activados"
	echo "DESACTIVADOS -> $desactivados"
fi



