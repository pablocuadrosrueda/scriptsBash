#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripción: Script que monitorea un servicio de manera automática con CRON y lo restaura en caso de que este caiga, cualquier tipo de incidencia
#será anotada en un archivo.log a elección del usuario
#systemctl is-active nombre_servicio → para saber si está activo.
#systemctl restart nombre_servicio → para reiniciarlo si está caído.
#Este archivo solo se puede ejecutar si el usuario root

#<--------------------------RELLENAR POR EL USUARIO-------------------------->
#Servicio a monitorear
servicio="ebtables"
#Ruta absoluta al archivo.log
rutalog=""
#<--------------------------------------------------------------------------->

if [[ $# != 0 ]]; then
	echo "ERROR. USO sudo $0"
	exit 1	
else
	usu=$(whoami)
	if [[ "$usu" != "root" ]]; then
		echo "ERROR. sudo $0"
		exit 1
	fi
	act=$(systemctl is-active $servicio)
	if [[ "$act" == "inactive" ]]; then
		error=$( systemctl restart "$servicio" 2>&1 )
		#if [[ -n "$error" ]]; then
		#	echo "ERROR EN LA RESTAURACIÓN DEL SERVICIO $servicio"
		#else
		#	echo "EXITO"
		#fi		
	fi
fi
