#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion:
#1 Compruebe numero de argumento = 1
#2 COmpruebe si existe ese direcotrio en el directorio bae del usuario ($HOME)
#3 Si existe ese directorio en el directorio base comprueba permisos de lectura y ejecucion
#4 Para su contenido: si es un fichero ordinario, interpreta todos los permisos, diciendo los permisos para prop, grupo y otros
#

#Comprobamos numero de argumentos
if [[ $# != 1 ]]; then
	echo "ERROR. USO $0 dir"
else
	#Paso 2
	usuario=$( whoami )
	orden=$( find "/home/pablocuadroos/" -name $1 )
	ruta=$( realpath $1 )
	if [ $? -eq 0 ] && [ -d $ruta ] ; then
		#Paso 3
		permisos_dir=$( stat -c %A "$ruta" )
		#echo "PERMISOS DEL DIRECTORIO: $permisos_dir"
		if [ -x "$ruta" ]; then
			echo "$1 SI tiene permisos de ejecución"
		else
			echo "$1 NO tiene permisos de ejecución"
		fi
		if [ -r "$ruta" ]; then
			echo "$1 SI tiene permisos de lectura"
		else
			echo "$1 NO tiene permisos de lectura"
		fi
		
		for fichero in "$ruta"/*; do 
			if [ -f $fichero ]; then
				echo "############################Procesando el fichero $fichero############################"
				#Comprobamos permisos para el propietario
				permisos=$( stat -c %a $fichero )
				echo "PERMISOS TOTALES -> $permisos"
				for (( i=0; i<${#permisos}; i++ )); do
				    digito=${permisos:$i:1}
				    #Comprobamos propietario
				    if [[ $i == 0 ]]; then
				    	echo "PROPIETARIO: "
				    elif [[ $i == 1 ]]; then
				    	echo "GRUPO: "
				    else 
				    	echo "OTROS: "
				    fi 
				    if [[ $digito == 7 ]]; then
				    	echo "TIENE TODOS LOS PERMISOS"
				    elif [[ $digito == 6 ]]; then
				    	echo "TIENE PERMISOS DE LECTURA Y ESCRITURA"
				    elif [[ $digito == 5 ]]; then 
				    	echo "TIENE PERMISOS DE ESCRITURA Y EJECUCIÓN"
				    elif [[ $digito == 3 ]]; then
				    	echo "TIENE PERMISOS DE LECTURA Y EJECUCIÓN"
				    elif [[ $digito == 4 ]]; then
				    	echo "TIENE PERMISOS DE ESCRITURA"
				    elif [[ $digito == 2 ]]; then 
				    	echo "TIENE PERMISOS DE LECTURA"
				    elif [[ $digito == 1 ]]; then
				    	echo "TIENE PERMISOS DE EJECUCIÓN"
				    fi
				done
				echo "#######################################################################################################################"
			fi
		done
	fi
fi
