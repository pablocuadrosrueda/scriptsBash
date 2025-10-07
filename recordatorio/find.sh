#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: shell script que recibe un único argumento que es la ruta de un archivo en disco y verifica lo siguiente:
# si existe
# si es propiedad del usuario que ejecuta
# y si tiene permisos de ejecución


#Primero comprobamos que se introduce un único argumento
if [ $# -ne 1 ]; then
	echo "ERROR. Uso: $0 arg1"
else
	#Ahora comprobamos la existencia del mismo 
	if [ -f "$1" ]; then
		echo "El archivo $1 existe"
		#Ahora comprobamos si es propiedad del usuario que lo ejecuta 
		#COMANDO NUEVO: stat
		usu_ejecuta=$(whoami)
		usu_propietario=$(stat $1 -c %U)
		#echo "$usu_propietario == $usu_ejecuta"
		if [[ "$usu_ejecuta" == "$usu_propietario" ]]; then
			echo "El archivo $1 es propiedad del usuario que ejecuta"
		else
			echo "El archivo $1 NO es propiedad del usuario que ejecuta"
		fi
		#Por último comprobamos si el fichero tiene permisos de ejecución
		#Lo vamos a hacer de la siguiente forma, para que tenga permisos de ejecución ( si consideramos la representación de permisos numérica )
		# El número debe ser impar ya que : 4 -> r ; 2 -> w ; x->1 por tanto vamos a extraer dicho número con el siguiente comando
		permisos=$(stat $1 -c %a)
		resto=$(($permisos % 2))
		if [ $resto -ne 0 ]; then
			echo "El archivo $1 tiene permisos de ejecución"
		else
			echo "El archivo $1 no tiene permisos de ejecución"
		fi	
	else
		echo "El archivo $1 NO existe"
	fi
fi
