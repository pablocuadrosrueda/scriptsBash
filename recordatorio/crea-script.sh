#!/bin/bash
#Autor: Pablo Cuadros Rueda
#Descripcion: Crear un script. Primero comprobamos que este ya no exista, crear el archivo, darle permisos de ejecución y copiarlo al directorio /bin

#Bonus adiccional: para poder utilizarlo nosotros de cara a los futuros scripts lo que vamos a hacer es pasarle ya la cabecera de Autor, Descripcion
#directamente 


#Primero compruebo que el script recibe solo un argumento ( el nombre del script ) 
if [ $# -ne 1 ]; then
	echo "ERROR. Uso: ./ej5.sh arg1"
else
	#Ahora comprobamos que dicho archivo no exista ya previamente ( como todos los archivos creados se copian en /bin ) lo vamos a buscar tanto ahí
	#como en el directorio actual 
	if ! ls | grep -wq "$1" && ! ls "/bin/" | grep -wq "$1"; then
		#Ahora creamos el archivo 
		touch "$1.sh"
		printf "#!/bin/bash\n#Autor: Pablo Cuadros Rueda\n#Descripción:" >> "$1.sh"
		chmod +x "$1.sh"
		cp "$1.sh" "/bin/"
	else
		echo "ERROR. El archivo ya existe o bien en el directorio actual o en /bin"
	fi 
fi
