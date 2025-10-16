#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Enunciado del ejercicio:
#Parámetros de entrada:
#El primer argumento es una cadena de ADN (solo puede contener las letras A, C, G o T).
#Los siguientes argumentos son uno o varios ficheros de texto con extensión .adn.
#Ejemplo de ejecución: ./procesa_adn.sh CGA muestra1.adn muestra2.adn
#Validaciones previas:
#Si no se pasan argumentos, el script debe mostrar un mensaje de uso y terminar.
#Ejemplo:Uso: ./procesa_adn.sh <cadena_ADN> <fichero1.adn> [fichero2.adn ...]
#Comprobar que la cadena de ADN solo contiene las letras A, C, G, T. Si contiene otros caracteres, mostrar error y terminar.
#Comprobar que cada fichero: Existe. Tiene permisos de lectura. Tiene extensión .adn.
#Procesamiento de cada fichero:
#Leer el fichero línea a línea.
#En cada línea, buscar todas las apariciones de la cadena de ADN pasada como argumento.
#Sustituir cada aparición por la misma cadena entre corchetes, es decir: "CGA" → "[CGA]".
#Guardar el resultado en un nuevo fichero con el mismo nombre pero extensión .sec. Ejemplo: muestra1.adn → muestra1.sec.
#Contar cuántas sustituciones se han hecho en total en ese fichero y mostrarlo por pantalla. Ejemplo: En el fichero muestra1.adn se encontraron 5 ocurrencias.
#Salida esperada:cPor cada fichero .adn procesado, se debe generar su correspondiente .sec.

if [[ $# < 2 ]]; then
	echo "ERROR. USO $0 <cadena> [ fich.adn ... fichN.adn ]"
	exit 1
else
	#Comprobamos primer argumento
	if [[ "$1" =~ [ACGT] ]]; then
		#variable para el primer caracter de la cadena
		primer=${1:0:1}
		#variable para controlar el caracter i esimo de $1
		#Navegamos los ficheros
		for((fich=2;fich<=$#;fich++)); do
			#echo ${!fich}
			#Comrpbamos existencia, permisos de lectura y extension adn
			if [ -f ${!fich} ] && [ -r ${!fich} ] && [[ "${!fich}" == *.adn ]]; then
				#leemos el fichero linea a linea
				cat ${!fich} > temp
				#creamos el fichero pero antes le quitamos la extensión
				copia=$( echo ${!fich} | cut -d"." -f1 )
				touch "$copia.sec"
				while read l; do
					#variable para una nueva línea
					nl=""
					#Vamos leyendo buscando el primer char del patrón
					for((j=0;j<${#l};j++)); do
						f=1
						#Tenemos dos maneras de actuar, si es el primer caracter del patrón o si no 
						patron=""
						if [[ "${l:j:1}" == "$primer" ]]; then
							patron="$patron[$primer"
							#Comprobamos los siguientes
							f=0 #flag
							for((x=1;x<=3;x++)); do
								#Comprobamos coincidencia con el patron
								if [[ "${l:j+x:1}" == "${1:x:1}" ]]; then
									patron=$patron${1:x:1} 
								else
									f=1
									break
								fi
							done	
							if [[ $f == 0 ]]; then
								patron="$patron]"
								j=$((j+3))
							fi
						fi
						if [[ $f == 0 ]]; then
							nl=$nl$patron
						else
							nl=$nl${l:j:1}
						fi
					done
					echo $nl >> "$copia.sec"
				done < temp
				rm temp
			fi			
		done
	else
		echo "ERROR en $1. $1 debe estar compuesto solo y exclusivemente de cualquier combinacion del siguiente conjunto [AGCT]"
		exit 1
	fi
fi


