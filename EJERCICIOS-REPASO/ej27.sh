#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:Realizar un Script que reciba el nombre de uno o más campos del archivo /proc/meminfo
#El script debe sumar el espacio que ocupan en total expresado en Bytes, Kbytes y Mbytes
#Además debe calcular la media y decir cuántos están por encima de la media y cuántos por debajo de la media
#Si un argumento no es un campo válido del archivo procesado, debe decirlo por pantalla y contar cuántos de los
#recibidos son archivos válidos y cuántos no
#

#Comprobamos cantidad de argumentos recibida
if [[ $# < 1 ]]; then
	echo "ERROR. USO: $0 campo1 ... campoN"
else
	#Definición de las variables
	espacio_totalMb=0
	espacio_totalB=0
	espacio_totalKb=0
	v=0
	nv=0
	lista_validos=""
	pem=0
	pdm=0
	#Procesamos argumentos
	for c in "$@"; do
		#Primero comprobamos que sea un campo válido
		campo=$( grep -w "$c" "/proc/meminfo" )
		if [ $? -eq 0 ]; then 
			#Ahora nos quedamos con el tamanio en Kb 
			tam=$( grep -w $c "/proc/meminfo" | awk '{print $2}' )
			lista_validos="$lista_validos $c"
			echo "El campo $c SI es un campo vaĺido"
			((v++))
			espacio_totalKb=$(( espacio_totalKb + tam ))
		else
			echo "El campo $c NO es un campo vaĺido"
			((nv++))
		fi	
	done 
	
	
	#Calculamos media
	 
	media=$(( $espacio_totalKb / $v ))
	for validos in $lista_validos; do
		tam=$( grep -w $validos "/proc/meminfo" | awk '{print $2}' ) 
		echo "TAM $tam"
		echo "VALIDOS $validos"
		echo "MEDIA $media"
		if [[ $tam -ge $media ]]; then
			((pem++))
		elif [[ $tam -le $media ]]; then
			((pdm++))
		fi
	done
	
	#Resultados finales
	echo "####################### RESULTADOS FINALES #######################" 
	espacio_totalMb=$(( $espacio_totalKb/1024 ))
	echo "ESPACIO TOTAL EN MB: $espacio_totalMb"
	echo "ESPACIO TOTAL EN KB: $espacio_totalKb"
	espacio_totalB=$(( $espacio_totalKb*1024 ))
	echo "ESPACIO TOTAL EN B: $espacio_totalB"
	echo "ARCHIVOS VÁLIDOS: $v"
	echo "ARCHIVOS NO VÁLIDOS: $nv"
	echo "ARCHIVOS POR ENCIMA DE LA MEDIA: $pem"
	echo "ARCHIVOS POR DEBAJO DE LA MEDIA: $pdm"
	echo "##################################################################" 
fi

