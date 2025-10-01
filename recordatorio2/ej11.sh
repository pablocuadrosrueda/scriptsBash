#!/bin/bash
#Autor:Pablo Cuadros Rueda
#Descripción: Script que recibe varios UIDs de un usuarios e identifice si estos existen y si además comparten UID con su GID

#Primero comprobamos que entra mínimo usuario
if [ $# -lt 1 ]; then
	echo "ERROR. USO: $0 usu1 usu2 ... usun"
else
	echo "Procesando listado de los usuarios..."
	for usu in $@; do
		#Vamos a utilizar el archivo /etc/passwd
		uid=$(cat /etc/passwd | grep -w $usu | cut -d ":" -f 3)
		#Comprobamos si existe el usuario comparando las cadenas, deberían coincidir
		if [[ "$usu" == "$uid" ]]; then
			echo "El usuario con UID -> $usu existe"
			gid=$(cat /etc/passwd | grep -w $usu | cut -d ":" -f 4)
			if [[ "$uid" == "$gid" ]]; then
				echo "El usuario con UID -> $usu comparte GID -> $gid"
			fi
		else
			echo "El usuario $usu NO existe"
		fi
	done
fi	
