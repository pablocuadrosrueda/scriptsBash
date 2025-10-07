#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: script que reciba una lista de Ips y devuelva si son o no alcanzables

#Primero compruebo que recibo mínimo un parámetro 
if [ $# -lt 1 ]; then
	echo "ERROR. USO: $0 [ip1] [ip2] [ip3] ... [ipN]"
else
	#Recorremos la lista de parametros 
	for ip in $@; do
		#Vamos a utilizar la orden ping con las opciones -c ( para especidifar el número de paquetes) y -q para salida silenciosa
		ping "$ip" -c 1 -q -W 0.5 >> /dev/null
		#Con esta opcion eliminamos la salida del comando en si, ya que con -q solo borramos el intercambio de los paquetes
		if [ $? -eq 0 ]; then
			echo "La IP -> $ip , es alcanzable"
		else
			echo "La IP -> $ip , NO es alcanzable"	
		fi
	done
fi

