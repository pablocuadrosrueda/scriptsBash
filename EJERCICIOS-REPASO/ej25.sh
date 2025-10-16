#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:16. La orden tar permite empaquetar varios archivos en uno solo y si se quiere, el
#resultado se puede comprimir. Por ejemplo: tar czf copia.tar.gz fichero1 fichero2, crea un
#archivo llamado copia.tar.gz que contiene los archivos: fichero1 y fichero2
#empaquetados y comprimidos en formato zip.
#Escribe un shell script que reciba como argumentos un nombre y un directorio y que cree
#un archivo comprimido con los archivos del directorio (sin subdirectorios) y que se llame:
#[nombre].tar.gz, donde [nombre] es el nombre que se da como argumento. Si el
#nombre que se da como argumento ya termina en tar.gz entonces no hay que añadirle
#esa extensión, si no, hay que añadírsela


#Comprobamos parametros:
#Debemos recibir tanto un nombre como un directorio 
if [[ $# != 2 ]]; then 
	echo "ERROR. USO $0 nombre directorio"
else
	#Ahora comprobamos que el direcotorio sea un directorio válido
	if [ ! -d $2 ]; then
		echo "ERROR. $2 NO es un directorio válido"
	fi
	#Ahora recorremos los archivos del directorio en cuestión
	#En la cadena archivos vamos a introducir todos los archivos para la orden tar
	archivos=""
	for fich in "$2"/*; do
		if [ -f $fich ]; then
			archivos="$fich $archivos"
		fi
	done
	#Ahora vamos con la segunda parte. el archivo debe tener el nombre -> [$1].tar.gz y debemos comprobar si tiene ya la extension o no para aÑadirla
	#Si no tiene la extensión la añadimos
	if [[ "$1" != *.tar.gz ]]; then
		nombre="$nombre.tar.gz"
	fi
	#Por último ejecutamos la orden
	echo $archivos
	tar czf "$1.tar.gz" $archivos
	if [ $? -eq 0 ]; then
		echo "EXITO"
	else
		echo "ERROR en la operación"
	fi
fi
