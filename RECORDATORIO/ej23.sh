#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: EScribe un shell script que reciba dos argumentos, un directorio y una extensión.
#Para todos los archivos que son ejecutables de ese directorio,
#le añade esa extensión la sustitye por la que se ha pasado como argumento.
#Debe contar el número de archivos a los que ha añadido o cambiado la extensión.
#Nota Debe comrpobar los argumetnos de entrada.
#
#| Expresión    | ¿Qué hace?                          |
#| ------------ | ----------------------------------- |
#| `${var%.*}`  | Elimina la última extensión (`.sh`) |
#| `${var%%.*}` | Elimina todo desde el primer punto  |
#

#Recibe dos argumentos un directorio y una extensión
if [[ $# != 2 ]]; then 
	echo "ERROR. USO $0 dir ext"
else
	c=0
	#Comprobamos si el $1 es un directorio
	if [ ! -d $1 ]; then
		echo "ERROR, se espera que el primer argumento sea un directorio válido"
	else
		#Recorremos el directorio en busca de archivos ejecutables
		for fich in $1/*; do
			#Si fich es un fichero válido y es ejecutable
			if [ -f $fich ] && [ -x $fich ]; then
				#Ahora comprobamos si no tiene extensión para evitar la sustitución
				if [[ "$fich" != *.* ]]; then
					#Si no tiene extensión se la añadimos
					mv "$fich" "$fich.$2"
				else
					#Tenemos que sustituirla 
					#Nos quedamos con la ruta absoluta al archivo 
					ruta=$( dirname $fich )
					#nombre_sin_ext=$( basename $fich | cut -d"." -f1 )
					nombre=$( basename $fich )
					nombre_sin_ext="${nombre%%.*}"
					mv "$fich" "$ruta/$nombre_sin_ext.$2"
				fi
				((c++))
			fi
		done
	fi 
fi

echo "ARCHIVOS MODIFICADOS $c"
