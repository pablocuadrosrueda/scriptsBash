#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Programa que recibe un único argumento, el nombre de una orden y diga si dicha orden existe ya o no
#Nota: este script es susceptible a ejecutar ordenes peligrosas como rm / -f por tanto solo se podrá ejecutar como administrador por lo que 
#añadiremos la condición
#Primero comprobamos que el usuario que ejecuta es root
usu=$((whoami))
if [[ "root" != "$usu" ]]; then 
#Después comprobamos que se reciba únicamente un argumento
	if [ $# -ne 1 ]; then 
		echo "ERROR. USO: $0 orden"
	else
		#Comprobamos si existe la orden (primer intento)
		#Mandas tambien el stderr a $1
		$1 >> /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "LA ORDEN $1 EXISTE"
		else
			echo "LA ORDEN $1 NO EXISTE"
		fi	
	fi
else
	echo "Solo el administrador del equipo puede ejecutar este script"
fi
