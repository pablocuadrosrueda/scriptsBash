#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Programa que recibe tres o mas argumentos -> 1 CLAVE -> 2 LETRAS -> 3 VARIOS FICHEROS
# 1 Compruebe que ambas cadenas tienen exactamente cinco caracteres
# 2 Compruebe que CLAVE tiene CHAR ESPECIALES y LETRAS son CARACTERES ALFANUMERICOS
# 3 Si del TERCER ARGUMENTO en adelante es un fichero ordinario y tiene PERMISO R se codifica
# 4 LA CLAVE SUSTITUYE A LA LETRAS POR POSICION
# 5 EL TEXTO ORIGINAL SE GUARDA EN UN FICHERO CON MISMO NOMBRE Y EXT .cod
# 6 PARA CADA FICHERO DEBE CONTAR: ... NUMERO DE LINEAS PROCESADAS Y NUMERO TOTAL DE FICHEROS PROCESADOS
#

#Comprobamos numero de argumentos 
if [[ $# < 3 ]]; then
	echo "ERROR. USO: $0 clave letras [ fichero1 ... ficheroN ]"
else
	#Comprobamos que los argumentos CLAVE y LETRAS tienen exactamente 5 carácteres
	if [[ "$1" == ????? ]] && [[ "$2" == ????? ]]; then
		#Comprobamos que CLAVE tenga caracteres especiales y LETRAS alfanuméricos
		echo "CORRECTO"
		if [[ "$1" =~ [^a-zA-Z0-9]{5} ]]; then
			echo "La clave tiene 5 caracteres y ninguno alfanumérico"
		else
			echo "ERROR. La clave debe estar compuesta exactamente de caracteres NO alfanuméricos"
			exit 1
		fi
		if [[ "$2" =~ [a-zA-Z0-9]{5} ]]; then
			echo "Las letras son caracters alfanuméricos"
		else
			echo "ERROR. El argumento 'letras' debe estar compuesto exactamente de caracteres alfanuméricos"
			exit 1
		fi
		
		#Recorremos la lista de ficheros ordinarios
		CLAVE=$1
		LETRAS=$2
		fprocesados=0
		shift 2
		
		for fichero in "$@"; do
			numlineas=0
			echo "Procesando $fichero ..."
			#Comprobamos que sea un fichero ordinario y permiso -r y -w
			if [ -f $fichero ] && [ -r $fichero ] && [ -w $fichero ]; then
				#Codificamos
				#Primero hacemos la copia del contenido original 
				cp $fichero "$fichero.cod"
				#Leemos el fichero línea a línea
				((fprocesados++))
				#Leemos la copia ya que vamos a escribir en el fichero original 
				cp $fichero temp
				#Vaciamos el fichero original 
				> $fichero
				while read l; do
					((numlineas++))
					#Procesamos caracter a caracter de la línea
					for((j=0;j<${#l};j++)); do
						caracter=${l:$j:1}	
						#Comrpobamos si esta en $LETRAS y me quedo con la posicion
						esta=$( echo "$LETRAS"| grep -F -bo "$caracter" )
						if [ $? -eq 0 ]; then
							pos=$( echo "$esta" | cut -d":" -f1 )
							#sustitucion que le corresponde
							encriptado=${CLAVE:$pos:1}
							echo $encriptado
							#realizamos la sustitucion
							l="${l:0:$j}${encriptado}${l:$((j+1))}"	
						fi
					done
					echo "$l" >> $fichero
				done < temp
				rm temp
				echo "NUMERO DE LINEAS PROCESADAS $numlineas"
			else
				echo "El fichero $fichero no cumple las características"
			fi
		done
	else
		echo "ERROR. Los dos primeros argumentos deben tener exactamente 5 caracteres"
		exit 1
	fi
	echo "CANTIDADA DE FICHEROS PROCESADOS: $fprocesados"
fi
