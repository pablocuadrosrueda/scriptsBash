#!/bin/bash
#Autor:Pablo Cuadros Rueda
#Descripcion: Borran los archivos de una extension determinada en un directorio determinado y que sean anteriores a una fecha dada

#El programa recibe una exntensión,un directorio y una fecha

if [[ $# != 3 ]]; then
	echo "ERROR. USO extension directorio fecha{formato: AAAA-MM-DD}"
else
	#Comprobamos si el segundo archivo es un directorio 
	if [ ! -d "$2" ]; then
		echo "ERROR. El segundo argumento no es un directorio válido"
		exit 1;
	else
		#Comprobamos si nos han introducido una fecha válida
		if [[ "$3" =~ ^([0-9]{4})-([0][1-9]|1[0-2])-([0-2][0-9]|3[0-1])$  ]]; then
			#Ahora buscamos los archivos anteriores a esa fecha y con esa extensión
			#Recorremos el directorio
			for i in $2/*;do
				echo "Procesando archivo $i"
				#Procesamos la extension
				#nos quedamos el nombre del archivo sin la extension
				nombre_sin_ext=$(echo $i | cut -d"." -f2)
				#Validando
				echo "$i =? .$nombre_sin_ext$1"
				if [[ "$i" == ".$nombre_sin_ext$1" ]]; then
					#Ahora comprobamos si son anteriores a la fecha
					#Para extraer la fecha podemos usar stat
					fecha=$(stat -c %x $i | cut -d " " -f1)
					echo "$fecha <? $3"
					if [[ "$fecha" < "$3" ]]; then
						echo "Borrando..."
					fi			
				fi
			done
		else
			echo "ERROR. El tercer argumento no es una fecha válida"
			exit 1;
		fi
	fi
	
fi
