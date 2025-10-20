#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Script que monitorea un servicio de manera automática con CRON y lo restaura en caso de que este caiga, cualquier tipo de incidencia
#será anotada en un archivo.log a elección del usuario
#systemctl is-active nombre_servicio → para saber si está activo.
#systemctl restart nombre_servicio → para reiniciarlo si está caído.
#Este archivo solo se puede ejecutar si el usuario root

################ APRENDIZAJE DE AUTOMATIZACIÓN ################

#| Concepto              | Qué hace                                                |
#| --------------------- | ------------------------------------------------------- |
#| cron                  | Programa que ejecuta tareas automáticamente             |
#| crond                 | Servicio en segundo plano que revisa los crontabs       |
#| crontab               | Archivo con tareas y horarios                           |
#| redirección >> y 2>&1 | Guarda salida y errores en un log para poder revisarlos |

################################################################


#<--------------------------RELLENAR POR EL USUARIO-------------------------->
#Servicio a monitorear
servicio="ssh"
#Ruta absoluta al archivo.csv ( para correcto funcionamiento el archivo debe estar completamente vacío )
rutalog="/home/pablocuadroos/Desktop/scriptsBash/RESTAURADOR-SERVICIOS/data/log.csv"
#<--------------------------------------------------------------------------->

################ FUNCIÓN DE REGISTRO PARA LOG ################

# 3 argumentos
registralog() {
	local estado="$1"
	local accion="$2"
	local resultado="$3"
	local usu=$( whoami )
	local host=$( hostname )
	local fecha=$( date '+%Y-%m-%d %H:%M:%S' )
	echo "$fecha,$servicio,$estado,$accion,$resultado,$usu,$host" >> "$rutalog"
	echo "$fecha,$servicio,$estado,$accion,$resultado,$usu,$host" 		
}

################ CARGA DEL ARCHIVO DE LOGS ################

if [ ! -f $rutalog ]; then
	echo "El archivo $rutalog no existe"
	exit 1
fi

# ( Primera vez en caso de que el fichero esté vacío )
############### AGREGAMOS PRIMERA LÍNEA AL FICHERO ###############

if [ ! -s "$rutalog" ]; then
	echo "timestamp,servicio,estado,accion_tomada,resultado,usuario,hostname" > $rutalog
fi


if [[ $# != 0 ]]; then
	echo "ERROR. USO sudo $0"
	exit 1	
else
	f=0
	usu=$(whoami)
	if [[ "$usu" != "root" ]]; then
		echo "ERROR. sudo $0"
		exit 1
	fi
	error=""
	act=$(systemctl is-active $servicio)
	if [[ "$act" == "inactive" ]]; then
		#error=$( systemctl restart "$servicio" 2>&1 )
		error=$( systemctl restart "$servicio" )
		f=1		
	fi
	
	if [ -n $error ]; then 
		error="TODO OK"
	fi
	
	accion="nada"
	if [[ $f == 1 ]]; then
		accion="reinicio" 
	fi		
	registralog "$act" "$accion" "$error"
fi
