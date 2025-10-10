#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Escribe un shell script que reciba una o varias cadenas por parámetro, y compruebe si
#son o no un palíndromo.

#Recibimos dos argumentos

if [[ $# < 2 ]]; then
	echo "ERROR. USO: $0 cadena1 cadena2"
else 
	for str in $@; do
		long=$((${#str}/2))
		long2=$((${#str}-1))
		flag=0
		for((i=0;i<long;i++));do
			c="${str:i:1}"
			cf="${str:long2:1}"
			if [[ $c != $cf ]]; then
				echo "La cadena $str NO es palíndromo"
				flag=1
				break; 	
			fi
			((long2--))
		done
		if [[ $flag == 0 ]]; then 
			echo "La cadena $str Sí es un palíndromo" 
		fi
	done
fi
