#!/bin/bash
#Autor:Pablo Cuadros Rueda
#Descripción:Script que encuentra los usuarios bloqueados

#Este script solo lo debe de ejecutar el administrador por tanto comprobamos si es root quien lo ejecuta
usu=$(whoami)
if [[ "$usu" == "root" ]]; then
#Este script no espera recibir ningún argumento
	if [ $# -ne 0 ]; then
		echo "ERROR. USO: $0"
	else
		echo "Encontrando usuarios bloqueados..."
	fi
	#Usamos un fichero temporal que recorreremos
	touch temp.txt 
	cat /etc/passwd >> temp.txt
	while IFS=: read -r nombre passwd resto; do
    	# Mostramos la 'línea' procesada (composición a partir de los campos leídos)
    		echo "Procesando linea: $nombre:$passwd:$(printf '%s' "$resto" | cut -c1-30)..."
    		# Comprobamos si el campo de contraseña comienza por '!'
    		if [[ "$passwd" == \!* ]]; then
        		echo "El usuario con nombre $nombre está bloqueado"
    		fi
	done < /etc/shadow
else
	echo "ERROR -> Solo root puede ejecutar este script"
	rm temp.txt
fi
