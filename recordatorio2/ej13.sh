#:Descripcion: Escribe un shell script que se llame usrslogin.sh que reciba varios nombres de usuario o logins, y para cada login compruebe si existe una cuenta con ese nombre de usuario. Debe decir si ese nombre está libre o si hay ya un usuario con ese nombre.

#Para este script recordemos que debemos utilizar el archivo /etc/passwd

#Primero comprobamos que se nos pasa mínimo un usuario 
if [ $# -lt 1 ]; then 
	echo "ERROR. USO: $0 usu1 usu2 usu3 ... usuN"
else
	#Ahora iteramos la lista de usuarios y comprobamos las especificaciones del ejercicio
	for usu in "$@"; do
		#Vamos a buscar el usuario en el fichero /etc/passwd con la orden grep 
		busca=$(cut -d ":" -f1 /etc/passwd | grep -w "$usu")
		#Comprobamos la orden
		if [ $? -eq 0 ]; then
			echo "El nombre de usuario $usu, ya existe"
		else
			echo "El nombre de usuario $usu, No existe"
		fi
	done
fi
