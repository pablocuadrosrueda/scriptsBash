#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción:Ecribe un shell script que reciba uno o más nombre de usuario, y compruebe para cada usuario si en el directorio base de ese usuario existe un directorio #llamado bin. Si existe, mueve los ficheros ejecutables al directorio bin, si no existe, lo crea y mueve todos los ficheros eiecutables que haya en el directorio base del usuario a ese directorio 
#Para formar de directorio base debes incluir esta línea:
#dirbase=$( dirname SHOME )/${1} )
#Para quedarte con los nombres de ficheros ejecutables debes incluir esta línea:
#exes=$ (Is -F | grep "*" | sed 's/*//g')
#ADICCIONAL -> USO DE SED s: sed 's/patrón/reemplazo/modificadores' archivo
#sustitución (search and replace).
#patrón: texto o regex a buscar.
#reemplazo: texto que reemplaza el patrón.
#Modificadores comunes:
#g: reemplaza todas las ocurrencias en la línea.
#i: ignora mayúsculas/minúsculas (case insensitive).
#p: imprime la línea (útil con -n).
#Si el programa no recibe argumentos debe escribir cual es la sintaxis correcta de la

#Primero comprobamos que recibimos al menos un nombre de usuario
if [ $# -lt 1 ]; then
	echo "ERROR. USO: $0 usu1 usu2 usu3 ... usuN"
else
	#Ahora iteramos la lista de usuarios
	for usu in "$@"; do
		#Antes de nada comprobamos que el usuario tenga directorio base
		if [ -d "/home/$usu" ]; then
			#Buscamos si existe un direcotio bin en el directorio base de dicho usuario
			if [ -d "/home/$usu" ]; then
				#Si no creamos el directorio base de dicho usuario
				mkdir "/home/$usu/bin"
			fi
				#Nos quedamos con todos los nombres de los ficheros ejecutables de ese direcotorio
				exes=$ (Is -F | grep "*" | sed 's/*//g')
				for i in $exes; do
				#Movemos cada fichero al directorio bin del usuario
					mv $exes "/home/$usu/bin"	
				done
		else 
			echo "El direcotrio base de $usu no existe"
		fi
	done
fi
