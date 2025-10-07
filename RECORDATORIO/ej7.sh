#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Escribe un programa que reciba una lista de nombres de usuario e imprima por pantalla si dichos usuarios existen o no

#Primero comprobamos que mínimo recibimos un usuario
if [ $# -lt 1 ]; then
	echo "ERROR. USO: ./ej1.sh usu1 usu2 usu3...usun"
else
	for usu in $@; do
		cat /etc/passwd | grep -qw "$usu"
		if [ $? -eq 0 ]; then
			echo "El usuario: $usu, existe"
		else
			echo "El usuario: $usu, NO existe"
		fi
	done
fi
