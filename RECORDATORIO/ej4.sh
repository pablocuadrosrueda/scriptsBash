#Escribe un script que reciba exactamente un argumento ( un nombre de usuario ) y compruebe si el directorio base del mismo existe 
#en un archivo llamado .profile. Si no existe que lo copie de /etc/skel y le de permisos de -rw-r--r--

#Primero comprobamos que reciba un argumento 
if [ $# -ne 1 ]; then
	echo "ERROR. Uso: ./ej4.sh arg"
else
	#Ahora comprobamos que dicho argumento sea un usuario vaĺido en /etc/passwd
	# -q para que no imprima y -w para coincidencia exacta 
	cat /etc/passwd | grep -qw "$1"
	#Si $? = 0 quiere decir que la orden anterior ha tenido exito 
	if [ $? -eq 0 ]; then
		#echo "Todo correcto"
		#Ahora comprobamos que el directorio base del mismo exista en el archivo profile
		nombre="/home/$1"
		ls "$nombre/" | grep -qw "profile"
		#Si existe damos un mensaje para confirmar su existencia
		if [ $? -eq 0 ]; then
			echo "El archivo $nombre/profile ya existe"
		else
			#Nos cambiamos al directorio /etc/skel
			cd /etc/skel
			cp profile "$nombre/"
			if [ $? -eq 0 ]; then
				echo "Copiado realizado con exito"
				chmod 644 "$nombre/profile"
			else
				echo "ERROR. Ha habido un error en la copia"
			fi		
		fi
	else
		echo "ERROR. El argumento introducido no es un usuario válido del sistema "
	fi
fi
