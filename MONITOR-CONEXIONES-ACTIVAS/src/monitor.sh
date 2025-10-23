#!/bin/bash
#Autor: Pablo Cuadros Rueda

#<----------------------------------------------------- OBLIGATORIO ----------------------------------------------------->
#Especificar ruta al fichero log.csv
ruta="/home/pablocuadroos/Desktop/scriptsBash/MONITOR-CONEXIONES-ACTIVAS/log/log.csv"
#<----------------------------------------------------------------------------------------------------------------------->

if [[ -z "$ruta" ]]; then
    echo "Error: RELLENE LA VARIABLE RUTA"
    exit 1
fi

if [ ! -f "$ruta" ] || [ ! -w "$ruta" ]; then
    echo "Error con la variable ruta, comprobar ruta al fichero, validez y permisos"
    exit 1
fi


#Función para escribir los datos en el log: 
escribe_log(){
	#Comprobamos si el fichero viene vacío para insertar la primera línea
	if [ ! -s $ruta ]; then
		echo "protocolo,estado,ipsalida,puertosalida,ipdestino,puertodestino,proceso" > $ruta	
	fi
		local protocolo="$1"
		local estado="$2"
		local ipsalida="$3"
		local puertosalida="$4"
		local ipdestino="$5"
		local puertodestino="$6"
		local proceso="$7"
		echo "$1,$2,$3,$4,$5,$6,$7" >> $ruta 
}

# Leemos la salida estándar de sstunop de manera periódica ( configurado en cron ) 
 #Filtramos aquellos servicios establecidos o a la escucha  ( ESTAB y LISTEN ) 
 
ss -tunaop | grep -E "(ESTAB | LISTEN)" > salida.txt
 
 #Procesamos cada línea de la salida 
 while read l; do
 	#Extraemos ahora cada campo del fichero 
 	protocolo=$( echo $l | awk '{print $1}' )
	estado=$( echo $l | awk '{ print $2 }' )
	ipsalida=$( echo $l | awk '{ print $5 }' | cut -d":" -f1 )
	puertosalida=$( echo $l | awk '{ print $5 }' | cut -d":" -f2 )
	ipdestino=$( echo $l | awk '{ print $6 }' | cut -d":" -f1 )
	puertodestino=$( echo $l | awk '{ print $6 }' | cut -d":" -f2 )
	proceso=$( echo $l | awk '{ print $7 }' )
	#Lo pasamos al log.csv	
	escribe_log $protocolo $estado $ipsalida $puertosalida $ipdestino $puertodestino $proceso
 done < salida.txt  
 
 rm salida.txt
 
