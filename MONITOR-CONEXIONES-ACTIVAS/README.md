# 🧠 Monitor de Conexiones Activas (Bash)

## 📋 Descripción general
Este proyecto forma parte de mi aprendizaje en **Bash scripting y administración de sistemas** dentro del área de ciberseguridad.  
El objetivo del script es **monitorizar las conexiones activas del sistema**, registrar su estado en formato CSV y detectar posibles **patrones de actividad sospechosa** (por ejemplo, IPs con un número inusual de conexiones abiertas).

---

## 🎯 Objetivos de aprendizaje
- Reforzar el uso de comandos de red (`ss`, `netstat`, `lsof`, etc.).
- Practicar manipulación de texto con `awk`, `grep`, `cut`, `sort`, `uniq`.
- Generar y gestionar archivos CSV desde Bash.
- Automatizar tareas con **cron**.
- Diseñar pequeños sistemas de **detección y logging de eventos**.

---

## ⚙️ Funcionamiento general

1. El script ejecuta periódicamente una captura de las conexiones activas del sistema (por ejemplo, cada 5 minutos).
2. Los datos se transforman en formato CSV con los siguientes campos:
timestamp,proto,src_ip,src_port,dst_ip,dst_port,state,pid_prog
3. Cada ejecución genera un archivo con nombre basado en la fecha y hora:
snapshots/conns-YYYYMMDD_HHMMSS.csv
4. El sistema mantiene una **rotación automática** de los últimos *N* snapshots.
5. Analiza la última captura para detectar IPs con demasiadas conexiones activas.
6. Si se supera el umbral definido, registra un evento en `alerts.log`.

---

## 🧩 Estructura del proyecto

monitor-conexiones/
│
├── src/
│ └── monitor.sh # Script principal
│
├── data/
│ ├── snapshots/ # Capturas periódicas en CSV
│ └── alerts.log # Registro de IPs sospechosas
│
├── cron/
│ └── cron.log # (Opcional) Salida del cron
│
├── README.md # Este archivo
└── LICENSE # Licencia opcional

---

## 🧰 Requisitos previos
- Sistema operativo Linux.
- Permisos de administrador (`sudo` si se requiere).
- Herramientas básicas: `ss`, `awk`, `grep`, `cut`, `sort`, `uniq`.
- Cron activo y configurado.

---

## 🚀 Uso básico

### Ejecución manual
```bash
sudo ./monitor.sh
Ejecución automática con cron
Editar el crontab:
sudo crontab -e
Ejemplo de tarea cada 5 minutos:
*/5 * * * * /ruta/completa/monitor.sh >> /ruta/completa/cron/cron.log 2>&1
📊 Resultados esperados
Ejemplo de línea registrada en el CSV:
2025-10-21 12:00:05,tcp,192.168.1.10,55566,8.8.8.8,53,ESTABLISHED,1234/dnsmasq
Ejemplo de alerta:
2025-10-21 12:05:00,192.168.1.25,87 conexiones activas
🧠 Posibles ampliaciones
Envío de alertas por correo o Telegram.
Dashboard visual con Python (Pandas + Matplotlib).
Detección de patrones de comportamiento anómalo.
Integración con Fail2ban o firewall automático.
👤 Autor
Pablo Cuadros Rueda
Proyecto formativo de ciberseguridad — Scripts Bash para automatización y análisis de red.
