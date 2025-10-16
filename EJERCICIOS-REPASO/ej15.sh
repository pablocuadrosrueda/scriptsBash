#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Programa que busque en todos los directorios los archivos que se llaman core y los cuente

#Este programa es peligroso ya que de haber algún error, el hecho de ir navegando y borrando por "/" podría tener consecuencias fatales.
#Por tanto lo vamos a hacer del directorio actual

#El programa no espera recibir argumento
if [[ $# != 0 ]]; then
	echo "No se esperan recibir argumentos"
else
	#Navegamos el directorio, borramos los archivos que se llamen core y los contamos
	c=0
	for archivo in *;do
		echo "Procesando archivo: $archivo"
		if [[ "$archivo" == "core" ]]; then
			echo "Borrando archivo..."
			#rm $archivo
			((c++))
		fi
	done 
	
	echo "Se han borrado $c archivos"
fi 
