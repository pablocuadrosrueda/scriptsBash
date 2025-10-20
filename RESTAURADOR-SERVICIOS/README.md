# Restaurador Automático de Servicios

## Autor
Pablo Cuadros Rueda

## Descripción
Este script está diseñado para **monitorear un servicio en Linux de manera automática** y restaurarlo en caso de que se detenga.  
Cualquier incidencia será registrada en un archivo CSV, incluyendo información sobre el **timestamp, servicio, acción tomada, resultado, usuario y hostname**.  

El script está pensado para ejecutarse con **cron**, permitiendo automatizar el proceso sin intervención manual.

---

## Requisitos
- Sistema Linux con `systemd` (`systemctl`)  
- Permisos de **root** para reiniciar servicios y escribir en archivos de logs  
- Bash 4+  

---

## Configuración

1. Editar el script para definir los siguientes campos:

```bash
# Servicio a monitorear
servicio="ssh"

# Ruta absoluta al archivo CSV de logs
rutalog="/ruta/completa/a/log.csv"
